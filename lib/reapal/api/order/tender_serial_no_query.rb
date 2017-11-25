module Reapal
  module Api
    module Order
      module TenderSerialNoQuery

        # 4.1 流水号查询（API）
        #
        # @param serial_no [ String ] 业务流水号（对应满标、还款、债权转让分账明细的流水号）
        # @param service_type [ String ] 调用接口 01：满标查询；02：还款查询；03：债权转让查询
        #
        # @return [ Hash ] 结果集
        #   * :result [String] 业务结果：'S/F/P'
        #   * :request_params [Hash] 请求参数
        #   * :response [Object] 请求返回对象
        #   * :error_code [String] 错误代号
        #   * :error_msg [String] 错误信息
        #   * :data: 具体业务返回信息
        #     * :serialNo [String] 业务流水号
        #     * :resultCode [String] 结果代码 0000：处理成功；0001：处理失败；0002：处理中
        #
        def tender_serial_no_query(serial_no, service_type)
          if service_type == '01'
            service = 'reapal.trust.tenderFinishSQuery'
          elsif service_type == '02'
            service = 'reapal.trust.tenderRefundSQuery'
          elsif service_type == '03'
            service = 'reapal.trust.tenderTransferSQuery'
          end

          post_path = '/reagw/agreement/agreeApi.htm'

          params = {
            serialNo: serial_no,
            queryTime: Time.now.strftime('%Y-%m-%d %H:%M:%S')
          }

          response = Http.post(service, params, @config, post_path)

          res = Reapal::Utils.api_result(params, response)

          # 查询类 api，http 没成功都返回 pending
          return res unless response.http_success?

          if Api::ErrorCode.tender_auth_query.include?(response.data[:errorCode])
            res[:result] = 'F'
            return res
          end

          # 其余 api 错误不知道
          return res unless response.data[:errorCode].nil?

          res[:result] = 'S'

          res
        end

      end # module Agree
    end
  end
end
