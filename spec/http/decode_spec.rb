# coding: utf-8
require 'reapal_helper'

RSpec.describe '解密' do
  it '错误信息，成功' do
    encryptkey_arg = 'LddVaEoi9VKFzZNZqBCtMTsuk+Bc91ao4o/UIwDL89uUZvuPqDtyMNMzM4T+5r7b0SzQwrztPJ68ETgvK8CMHT3ZOanEo9/NmnX89sM4wMNLpeZfKet0A+30/gqtTeDpvc+137u/OXsRhiG2eZD43j7WCH1BJumIFdzybZ4V4Kc='

    data_arg = 'OFCEVHoLF+wtU79F4cI3E60DD32TfQ2jyxcoT1tMcc/2WOT2aEg0Ml24sIaLbeQUbysKG9LpqDdznecHxl0vFOx9xg+AI8p7XeHFhEvBEQwVhfMzyIHQ+gzyep4MswwGsolHJb/wDZrpvZkFmjRJmCfjV/aHsVwzk+gne7S2On7Rcw7pmiy+N4DhV9P0eSa6mstXbRwZ265GIYt9uhfdqRlvQVTGODnHSFBEJebtteou8FPZ8qeyg3JrVZ6Fp65oupnfYHeTHdwkHNR3czyrPju6SCpaB5Ue78BufhXgBQ1dSCuUnxBVwkTHFGUivXqX//AVyU41u/st0jT5g9eVd13eEqKUHSEOa9OJfj5kCKo1+7L+OszHLP+Y4gNSHIje'

    result = Reapal::Http::Decode.decode_notify_data(encryptkey_arg, data_arg, client.config)

    expect(result[:data_valid]).to eq(true)
    expect(result[:resData]).to eq(nil)
    expect(result[:resError]).not_to eq(nil)
    expect(result[:resError][:errorCode]).not_to eq('0000')
  end

  it '成功信息，成功' do
    encryptkey_arg = 'ClVcLPJaH28n7wpj6xJgj7ULwWk+B/w+GKiBPdSKL76ozf5lIavd9/T1j7Hltu7pIhri4CYpuQV+iKraBDA9gDw5KD75Zv+tyeTpgohoUkwl1CHBDWYiR1wjrSsesmEFgmWX/n+JoWEiASiQ6fyBu2AMAI/cuDXQhSxklV7BS1E='

    data_arg = 'p9v2jmcui862uKj0EDmlIsj/vQj4cJ1bH9yIDmyo0W5Eyk8nzeBQL+CQAzZqnFRzYcttY+MUZxS9A2AYzFnviam9qCtdjnMHBKshOG4ND16BFiKpjy9TGOpGBRAmHdKnsI7uzagEkOVKKFh8O4F8tL2BniYPHsKE1yx365pCIGWZmyXIblT8MIFiQ2TExuft2CdIDR2MNJpM1FUeITZCAWY+SbNwh+ofRNS7PV+Qf2gwjIjSDCVrSMD/XjWl8hjhUMjX4IBKqgyCc+swMiuSyNUMaqKFembxLJSWR49Y2r+Rjg/+gZ7w+vGwYPC/J8tRtVS+WAKcc9xyrcaCWFSaAgcpvd7JxEzA0bYVKm27GmJgFpcuL7ElL7s1Vi843FtjGkPCrmUvje++yfSybcW8fvoib+IbOG5/jEHrN2e84FBREgqgp2nRyXRYyNUs/k6+qUXGO3x4YTY9zNItIMVFccPySi3ea+vLhnh/KlBH+IflgfzW3R7FwAyzgAhegT59rD8x1i/KU4SWW2GtJrygiYQoXN3Z/L/dDpR9M66f6JhJGbFueNhf416f+Av9oZ0n'

    result = Reapal::Http::Decode.decode_notify_data(encryptkey_arg, data_arg, client.config)

    expect(result[:data_valid]).to eq(true)
    expect(result[:resData]).not_to eq(nil)
    expect(result[:resError]).to eq(nil)
    expect(result[:resData][:resultCode]).to eq('0000')
  end
end
