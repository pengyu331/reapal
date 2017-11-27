# coding: utf-8
module Reapal
  module Api
    module CommunicateResultHelper

      # 操作类的 api，统一返回处理
      #
      # @param request_type [Symbole] 操作类（:operate）/查询类(:query)
      # @param service [ String ] 富民的服务
      # @param params [ Hash ] 参数
      # @param post_path [ String ] post url
      # @param fail_codes [ Array ] 错误返回码
      # @param success_codes [ String ] 【业务】【明确的】正确返回码（而不是申请成功这类）
      #
      # @return [ Hash ] 结果集(见通用返回)
      #
      def operate_post(request_type, service, params, post_path, fail_codes, success_codes, version=nil)
        response = Http.post(service, params, @config, post_path, version)

        res = Reapal::Utils.api_result(params, response)

        if :operate == request_type
          # 向服务器发送操作，超时类的都应该当 pending 处理
          return res if response.http_pending?
        elsif :query == request_type
          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?
        else
          raise "未知的请求类型，请选择设置：操作类（:operate）/查询类(:query)"
        end

        # 确定的错误
        if fail_codes.include?(response.data[:errorCode])
          res[:result] = "F"
          return res
        end

        # 其余 api 错误不知道
        return res unless response.data[:errorCode].nil?

        # 确定的成功返回码
        if success_codes.include?(response.data[:resultCode])
          res[:result] = "S"
        end

        res
      end

    end # CommunicateResultHelper
  end
end
