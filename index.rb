require 'sinatra'
require 'json'
require 'data_mapper'

get '/:article_id' do
  star = Star.first( article_id: params['article_id'] )
  @count = star ? star.count : 0
  puts @count
  erb params['article_id'].to_sym
end

post '/', provides: :json do
  article_id = params['article_id']
  star = Star.first( article_id: article_id )
  if session[article_id]
    session[article_id] = session[article_id].to_i + 1
  else
    if star
      session[article_id] = star.count + 1
    else
      star = Star.create( article_id: article_id, count: 1 )
      session[article_id] = 1
    end
  end
  star.update( count: session[article_id].to_i )
  status 200
  content_type :json
  { count: session[article_id].to_i }.to_json
end

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/star.db")
class Star
  include DataMapper::Resource
  property :id, Serial
  property :article_id, String
  property :count, Integer
end
DataMapper.finalize
Star.auto_upgrade!