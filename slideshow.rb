require 'sinatra'
require 'uv'

get '/' do
  redirect '/slides/0'
end

get '/slides/:slide' do
  begin
    @slide = params[:slide].to_i
    @next_slide = @slide + 1
    @prev_slide = @slide - 1
    haml "slide#{@slide}".to_sym
  rescue Errno::ENOENT
    p $!
    redirect '/slides/0'
  end
end

helpers do
  def load_snippet(snippet) 
    code = IO.read('snippets/' + snippet)
    Uv.parse( code, "xhtml", "ruby", false, "slush_poppies")
  end
end

__END__

@@ layout

%html
  %head
    %title Slide #{@slide}
    %script{src:'/js/jquery.min.js'} 
    %script{src:'/js/jquery.hotkeys.js'}
    %script{src:'/js/jquery.controls.js'}
    %link{href:'/css/slideshow.css', media:'all', rel:'stylesheet', type:'text/css'}
    %link{href:'/css/slush_poppies.css', media:'all', rel:'stylesheet', type:'text/css'}
    %link{href: 'http://fonts.googleapis.com/css?family=Yanone+Kaffeesatz:400,700,300,200', media:'all', rel:'stylesheet', type:'text/css'}

    :javascript
      $(document).ready(function(){
        $("body").keydown(function(e) {
          if(e.keyCode == 37) { // left arrow
            window.location = '/slides/#{@prev_slide}'; 
          }
          else if(e.keyCode == 39) { // right arrow
            window.location = '/slides/#{@next_slide}'; 
          }
        });
      });
  %body
    %h4 #{@slide}
    %a#show_info.nav (i)nfo
    = yield

@@ slide0 
#content
  %h1.center.extra-large SEO
  %h2.center Snake oil or pure gold?
#notes
  %h2 Notes header
    
@@ slide1
#content
  %h3 Definition
#notes{ data: { class: 'alternate'} }
  %img{src: 'http://i.qkme.me/3puf2g.jpg'}
    
@@ slide2
#content
  %h3 Definition

#notes{ data: { class: 'emphasis'} }
  %h3 Emphasis slide

@@ slide3
#content
  %h3 Definition
  %ul
    %li SQL is a relational database language.
    %li Devs use SQL to fetch/insert data in and out of our database.
    %li When we want to fetch a user with SQL, what's that look like?
  Query:
  ~load_snippet('sql_example.sql')
  Result:
  ~load_snippet('ruby_example.rb')

#notes{ data: { class: 'emphasis'} }
  %h2 Relational?
    