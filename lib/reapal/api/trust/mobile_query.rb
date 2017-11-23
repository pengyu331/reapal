# coding: utf-8

module Reapal
  module Api
    module Trust
      module MobileQuery

        # 1.8 手机号查询
        #
        # @param contracts [ String ] 用户协议号
        #
        # @return [ Hash ] 结果集
        #   * :success [bool] 查询结果是否有效
        #   * :mobile [String] 用户手机号
        #


        def mobile_query(contracts)
          service = 'reapal.trust.mobileQuery'
          post_path = '/reagw/user/restApi.htm'

          params = {
            contracts: contracts,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S'),
          }

          response = Http.post(service, params, @config, post_path)

          # 如果数据不合法
          unless response.data_valid
            return {success: false}
          end

          # 如果网络出错，包括超时或者非200类数据
          unless response.http_response.kind_of?(Net::HTTPSuccess)
            return {success: false}
          end

          # 如果 api 出异常
          if response.data[:errorCode]
            return {success: false}
          end

          {
            success: true,
            mobile: response.data[:mobile]
          }
        end

      end
    end
  end
end
