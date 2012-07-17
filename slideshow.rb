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

/ Google keyword tool - https://adwords.google.com/o/Targeting/Explorer?__c=1000000000&__u=1000000000&ideaRequestType=KEYWORD_IDEAS
/ Query:
/ ~load_snippet('sql_example.sql')
/ Result:
/ ~load_snippet('ruby_example.rb')

/ http://www.webdistortion.com/2012/07/14/seo-for-developers/

@@ slide0 
#content
  %h1.center.extra-large SEO
  %h2.center (Search Engine Optimization)
#notes{ data: { class: 'alternate' } }
  %h1 Why do we care?
    
@@ slide1
#content
  %h2 FREE MONEY!
  %br/
  %img{src: '/images/stacks-of-money.jpeg'}

#notes{ data: { class: 'emphasis'} }
  %h2 Returns on SEO
  %ul
    %li Discovery our service
    %li Brand exposure
    %li New users
    %li Market awareness
    
  %p But seriously, it's like free money - we don't pay anything for organic traffic so there's only upside. We can never have too much organic traffic.

@@ slide2
#content
  %h2 Organic Traffic
  %p Organic traffic is our #1 source.
  %img{src: '/images/google_pie_graph.png'}
  %p More people come from Google than from anywhere else (that includes direct)....and we haven't even optimized our website for SEO yet. Huge potential.

#notes{ data: { class: 'emphasis'} }
  %h3 What about other search engines?
  %br/
  %img{src: '/images/other_pie_chart.png'}
    
  %p We can improve this, but optimizing for Google will provide us the biggest bang for our buck.

@@ slide3
#content
  %h3 SEO is important, but what is it?
  %p SEO is optimizing your website so search engines can index your content and rank your website in search results as high as possible.
  %p How do search engines do this?
  %ul
    %li They have 'spiders' that 'crawl' the internet going from website to website.
    %li When they reach your website, the robots click every link and build out a web of links on your website. 
    %li Once they map your website's structure, they parse, store, and weight the contents.
    %li Then they send all this information back to the mothership (Google) and they use an algorithm to rank your website amongst other websites for search queries (keywords).
  %p Every large search engine (Google, Yahoo, Bing, Ask) uses their own proprietary algorithm.

@@ slide4
#content
  %h2 Google PageRank
  %h3 How does it work?
  %p The exact algorithm is not and never will be published - it's worth billions upon billions of dollars, but we can infer a lot.
  %p We know they have a link analysis algorithm that creates weighted-results for search queries.
  %img{src: '/images/algorithm_gibberish.png'}
  %center
    %p ????????????????????

#notes{ data: { class: 'alternate'} }
  %h1 PageRank is smarter than us!

@@ slide5
#content
  %h2 PageRank Simplified  
  %h3 What really matters
  %ul
    %li Discovery - Google's awareness of your website existence and the content available.
    %li Amplifiers - aspects of your website that enhance your page ranking.
    %li Dampeners - aspects of your website that hurt your page ranking.

@@ slide6
#content
  %h2 PageRank Simplified  
  %ul
    %li 
      %span.highlight Discovery
    %li Amplifiers
    %li Dampeners

@@ slide7
#content
  %h2 Discovery
  %p Google has to know about your content before it can evaluate and index it.
  %ul
    %li Direct - you manually add your URL to Google's index.
    %li Backlinks - other websites link back to your website and its content.
    %li Structured linking - having an organized hierarchy of links.
    %li Following best HTML practices - alt tags for images, title tags for links, etc.
    %li Sitemaps - an HTML/XML file that lists every link you care about on your website.
    %li Product feeds - if you're an e-commerce website, you can send Google your inventory along with meta information.

#notes{ data: { class: 'emphasis'} }
  %h3 What do our sitemaps look like?
  %br/
  ~load_snippet('sitemap.xml')
  %p Foreboding: we can do much better than this.

@@ slide8
#content
  %h2 PageRank Simplified  
  %ul
    %li Discovery
    %li 
      %span.highlight Amplifiers
    %li Dampeners

@@ slide9
#content
  %h2 Amplifiers
  %p What makes some websites higher than others in rankings?
  %ul
    %li Quality - unique and genuine content trumps everything. PageRank is smart, they know whether your content is valuable to the user. 
    %li Speed - Google knows how long your page takes to load and they know users don't want to wait, so the speed of your website does influence your ranking.
    %li Usability - does your website need JavaScript to work? do you have too many ads? is your layout conducive to a good user experience?
    %li Number of backlinks - if people are linking to your website, you must have something worth sharing.
    %li Best coding practices - being HTML compliant, building descriptive URL schemes, and using all the proper HTML attributes is a signal to Google that you take care in the construction of the website.
    %li Best web practices - do you have FAQs? do you have a HTML sitemap/directory for your users? 

  %p PageRank is like a human being. It knows what's legit and not.

@@ slide10
#content
  %h2 PageRank Simplified  
  %ul
    %li Discovery
    %li Amplifiers
    %li 
      %span.highlight Dampeners

@@ slide11
#content
  %h2 Dampeners
  %p What will hurt you? 
  %ul
    %li 
      %b Keyword stuffing
      \- if you put too many keywords on your website, Google has a tougher time deciphering which ones actually matter.
    %li Quality - if other websites provide better versions of your content, you'll be ranked lower (i.e. GAP has better information about their brand than we can provide, therefore we will rank low when people search for GAP). 
    %li Speed - the slower your website, the worse your ranking.
    %li Number of backlinks - if you don't have a lot of backlinks, they judge you.
    %li Bad coding practices - if your code compliance is poor, it will hurt you.
  
@@ slide12
#content
  %h2 Dampeners
  %p 
    What will Google penalize you for? 
    %span.highlight Anything shady.
  %p PageRank is like a human being. It knows what's legit and what's not.
  %ul
    %li Cloaking - putting scrape-able content on the page, but hiding it in from the user.
    %li Low-value pages - if you create hollow pages that don't provide a lot of quality content.
    %li Link farms - if you try to game backlinks (i.e. make multiple websites that link back to each other).
    %li Plagiarism - if you use other people's content, they have ways of detecting who is the real author and they can issue penalties. 
  %p How serious are their penalties?

#notes{ data: { class: 'emphasis' } }
  %h3 WTF happened in early 2011?
  %p 
    eHow.com
    %br/
    %img{src: '/images/eHow-panda-update.png'}
  %p 
    Mahalo.com
    %br/
    %img{src: '/images/Mahalo-panda-update.png'}
  %p 
    Overstock.com
    %br/
    %img{src: '/images/Overstock-panda-update.png'}

@@ slide13
#content
  %h2 PageRank Summary
  %ul
    %li Make sure Google knows all of your content.
    %li Make sure your content is well-structured and provides high-value to the user.
    %li Use best practices in building your content.
    %li Keep your website clean and fast.
    %li Don't try to game their system.

  %p Google cares more about the user than they do about you. If you're doing something to get visits and the user isn't obtaining value, Google will know. 

@@ slide14
#content
  %h1 Developers vs. Product
  %h2 Whose job is it?
#notes{ data: { class: 'alternate' } }
  %h1 PRODUCT!
  %p Just kidding...

@@ slide15
#content
  %h1.center.extra-large SEO
  %h2.center It's a Team Effort

@@ slide16
#content
  %h2 What Product Should be Doing
  %p Build for the user and infuse SEO. Don't approach it from the wrong way. 
  %ul
    %li Define & communicate keywords - determining what keywords perform best for us is a large undertaking, but once we know what works best for us, communicate that to the team (developers) so we know what meta information to focus on (i.e. page titles, meta descriptions, alt tags, etc.).
    %li URLs - take them serious! Think hard about URL schemes. Grab a developer and bounce ideas off of them. When we change a URL at a later date, it hurts our SEO juice. 10k backlinks to /store is significantly more important than 5k backlinks to /items and 5k backlines to /store. Think about it.
    %li Sitemaps - are we adding a new feature? Make sure it's added to the HTML sitemap. Make sure we have FAQ content in place.
    %li Quality content - the content on a page matters. Copy and pasting is the devil for SEO. Be creative, take your time, make it count.
    %li Feature flows - does the feature flow smoothly? is it organized? is there a hierarchy? Can it be intertwined with another feature (i.e. Catalog) on our website?
    %li 
      %b Don't be shady! 
      \- Google doesn't like it. Developers don't like it. It feels dirty all over to code something that has negative, ulterior motives. 

@@ slide16
#content
  %h2 What Developers Should be Doing
  %p Get educated! Not knowing is not an excuse!
  %ul
    %li Don't be lazy - Have an image? Make sure there's alt text. Have a link? Make sure there's title text. Use the right elements (h1, h2, p, etc.)
    %li Think hard on meta - When you place the alt text, make it meaningful. If you care, you'll take the time to do it right.
    %li JavaScript beware - If a link requires jQuery to work, you're doing it wrong. If a bot can't get from page to page, you're doing it wrong. 
    %li Plan from the beginning - Before you start coding, think about SEO. SEO can dictate execution (i.e. don't bring content in via AJAX).
    %li 
      %b Don't be shady! 
      \- We're an ethical company. It something feels slimy, speakUP. 

/ slide17


/ Fixing shit. 
/ %ul
/   %li  

@@ slide20
#content
  %h2 What else can we do?
  %ul
    %li Expand the FAQ. If we get asked a question a lot (i.e. quality), write a full blog post addressing the issue and link to it from the FAQ. Some people want more than a 2-sentence explanation. 
    %li Create a customized product feed for each size (or brand or category).
    %li Investigate how to improve our Yahoo/Bing ranking.
    %li Introduce the HTML canonical attribute to our store, catalog, and bag feed links.
    %li Quality, used kids clothes related content creation.
    %li Mobile App SEO (ex: blog about app updates/releases/features).    