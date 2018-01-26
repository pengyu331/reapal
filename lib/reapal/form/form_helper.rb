# coding: utf-8
module Reapal
  module Form
    module DataHelper

      # 跳转到富民 Form 类的 api，统一返回处理
      #
      # @param service [ String ] 富民的服务
      # @param params [ Hash ] 参数
      # @param post_path [ String ] post url
      #
      # @return [ Hash ] 结果集
      #   * form_method
      #     * url
      #     * method
      #   * form_data
      #     * :merchant_id
      #     * :encryptkey
      #     * :data
      #
      def get_form_data(service, params, post_path, version=nil)
        request = Http.get_body(service, params, @config, version)

        {
          form_method: {
            :url => @config[:server_url] + post_path,
            :method => :post,
          },
          form_data: request
        }
      end

    end # DataHelper
  end
end
