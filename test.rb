require 'webrick' #require 'webrick'は「webrick」を呼び出している

#WEBrick::HTTPServer.newでWebrickのインスタンスを作成し、serverという名前のローカル変数に入れます。
server = WEBrick::HTTPServer.new({
  :DocumentRoot => '.',
  :CGIInterpreter => WEBrick::HTTPServlet::CGIHandler::Ruby,

  :Port => '3000',
})
['INT', 'TERM'].each {|signal|
  Signal.trap(signal){ server.shutdown }
}

server.mount('/test', WEBrick::HTTPServlet::ERBHandler, 'test.html.erb')
server.mount('/practice', WEBrick::HTTPServlet::ERBHandler, 'practice.html.erb')
#Webサーバを起動した状態で、（DocumentRootの値）/testというURLを送信すると、
#同じディレクトリ階層にあるtest.html.erbファイルを表示するという機能が付与されます。
#今回のDocumentRootは’.’ですから、”./test”というURLが送信されることになります。
server.mount('/indicate.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate.rb')
#↑この行を追加することで、test.html.erbの<form action="indicate.cgi">~</form>内部にある値をindicate.rbに送信出来るようになる
server.mount('/goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'goya.rb')
server.mount('/indicate_goya.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate_goya.rb')
server.mount('/indicate_goya_false.cgi', WEBrick::HTTPServlet::CGIHandler, 'indicate_goya_false.rb')


server.start
#server.startはその名の通り、Webrickのすたーと