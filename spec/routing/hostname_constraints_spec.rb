require 'spec_helper'

describe 'ルーティング' do
  specify '職員トップページ' do
    expect(get: 'http://baukis.example.com').to route_to(
                                                    host: 'baukis.example.com',
                                                    controller: 'staff/top',
                                                    action: 'index'
                                                )
  end

  specify '管理者ログインフォーム' do
    expect(get: 'http://baukis.example.com/admin/login').to route_to(
                                                                host: 'baukis.example.com',
                                                                controller: 'admin/sessions',
                                                                action: 'new'
                                                            )
  end

  specify '利用者トップページ' do
    expect(get: 'http://example.com').to route_to(
                                             host: 'example.com',
                                             controller: 'customer/top',
                                             action: 'index'
                                         )
  end

  specify 'ホスト名が対象外ならerrors/not_foundへ' do
    expect(get: 'http://foo.example.jp').to route_to(
                                                controller: 'errors',
                                                action: 'routing_error'
                                            )
  end

  specify '存在しないパスならerrors/not_foundへ' do
    expect(get: 'http://baukis.example.com/xyz').to route_to(
                                                        controller: 'errors',
                                                        action: 'routing_error',
                                                        anything: 'xyz'
                                                    )
  end
end