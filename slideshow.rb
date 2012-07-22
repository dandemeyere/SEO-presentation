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

@@ slide0 
#content
  %h1.center.extra-large SEO
  %h2.center (Search Engine Optimization)
#notes{ data: { class: 'alternate' } }
  %h1 Why do we care?
    
@@ slide1
#content
  %h2 It's all about the benjamins
  %br/
  %img{src: '/images/money.jpeg'}
  %p Seriously, organic traffic is like free money. We can never have too much organic traffic - unless you think having too much money or too many visitors is a bad thing.

#notes{ data: { class: 'emphasis'} }
  %h2 Returns on SEO
  %ul
    %li Discovery of our store and the clean out service
    %li thredUP brand exposure
    %li Market awareness of the 2nd-hand clothing market
    %li New users &amp; emails

@@ slide2
#content
  %h2 Organic Traffic is #1
  %br/
  %img{src: '/images/google_pie_graph.png'}
  %p More people come from Google than from anywhere else (that includes direct)....and we haven't even optimized our website for SEO yet. Huge potential.

#notes{ data: { class: 'emphasis'} }
  %h3 What about other search engines?
  %br/
  %img{src: '/images/other_pie_chart.png'}
    
  %p We can improve our Yahoo &amp; Bing traffic, but optimizing for Google first will yield the largest results.

@@ slide3
#content
  %h3 SEO is important, but what is it?
  %p SEO is optimizing your website so search engines can index your content easily and, through following best practices, rank your website in search results for the keywords you're targeting as high as possible.
  %p How do search engines work?
  %ul
    %li They have bots that crawl the internet going from website to website.
    %li When they reach your website, the bots (which are glorified scripts) click every link and build out a map of links on your website. 
    %li Once they map your website's structure, they parse, store, and weight the contents.
    %li Then they send all this information back to the mothership (Google) and they use an algorithm to rank your website amongst other websites for search queries (keywords).
  %p Every large search engine (Google, Yahoo, Bing, Ask) uses their own proprietary algorithm.

@@ slide4
#content
  %h2 Google PageRank
  %h3 How does PageRank work?
  %p The exact PageRank algorithm is not and never will be published - it's worth billions upon billions of dollars, but we can infer a lot.
  %p For example, we know they have a link analysis algorithm that creates weighted-results for search queries. Here is what a link analysis algorithm looks like:
  %img{src: '/images/algorithm_gibberish.png'}
  %center
    %p ????????????????????
#notes{ data: { class: 'emphasis'} }
  %h2 Google PageRank
  %p You would need a PHD in Computer Science Engineering to understand the algorithms at play with PageRank. Luckily, you don't need to know exactly how it works to optimize for PageRank. 

@@ slide5
#content
  %h2 PageRank Simplified  
  %h3 What really matters
  %br/
  %ul
    %li Discovery - Google's awareness of your website's existence and the content you offer.
    %li Amplifiers - aspects of your website that enhance your page ranking.
    %li Dampeners - aspects of your website that hurt your page ranking.

@@ slide6
#content
  %h2 PageRank Simplified  
  %ul.large
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
    %li Sitemaps - an HTML/XML file that lists every link you want Google (or your user) to know about on your website.
    %li Structured linking - having an organized hierarchy of links on your website that is easy for bots to traverse.
    %li Product feeds - if you're an e-commerce website, you can send Google your inventory along with meta information.

#notes{ data: { class: 'emphasis'} }
  %h3 What do our sitemaps look like?
  %br/
  ~load_snippet('sitemap.xml')
  %p Foreboding: this particular sitemap is grossly incompetent, more on this later.

@@ slide8
#content
  %h2 PageRank Simplified  
  %ul.large
    %li Discovery
    %li 
      %span.highlight Amplifiers
    %li Dampeners

@@ slide9
#content
  %h2 Amplifiers
  %p Things you can do that will elevate you above others in Google search results.
  %ul
    %li Quality - Unique and genuine content trumps everything. Google only cares if you're providing value to the user.
    %li Backlinks - The more websites that link to yours, the better your search rankings will be. The quality of the backlink is very important though.
    %li Speed - Google knows how long your page takes to load and they know users don't want to wait, so the speed of your website does influence your ranking.
    %li Usability - Does your website need JavaScript to work? Do you have too many ads? Is your layout conducive to a good user experience?
    %li Best coding practices - Being HTML compliant, using alt tag text for images, title tag text for links, building descriptive URL schemes, and using all the proper HTML attributes is a signal to Google that you take care in the construction of the website.
    %li Best web practices - Do you have FAQs? Do you have a HTML sitemap/directory for your users? 

  %p 
    %i PageRank is like a human being. It can deduce the legitimacy of your content.

@@ slide10
#content
  %h2 PageRank Simplified  
  %ul.large
    %li Discovery
    %li Amplifiers
    %li 
      %span.highlight Dampeners

@@ slide11
#content
  %h2 Dampeners (1 of 2)
  %p What will hurt you? 
  %ul
    %li 
      %b Keyword stuffing
      \- If you put too many keywords on your website, Google has a tougher time deciphering the signal from the noise. 
    %li Quality - If other websites provide better versions of your content, you'll be ranked lower (i.e. GAP has better information about their brand than we can provide, therefore we will rank lower when people search for GAP). 
    %li Speed - The slower your website, the worse your ranking.
    %li Number of backlinks - If you don't have a lot of backlinks, they judge you.
    %li Bad coding practices - If your code compliance is poor, it will hurt you.
  
@@ slide12
#content
  %h2 Dampeners (2 of 2)
  %p 
    What will Google penalize you for? 
    %span.highlight Anything shady.
  %p PageRank is extremely intelligent and is constantly evolving.
  %ul
    %li Cloaking - Putting scrape-able content on the page, but hiding it in from the user.
    %li Low-value pages - Creating hollow pages that don't provide a lot of quality content.
    %li Link farms - If you try to 'game' backlinks (i.e. make multiple websites that link back to each other).
    %li Plagiarism - If you use other people's content, they have ways of detecting who is the real author and they can issue penalties if you claim it as their own. 
  %p How serious are their penalties?

#notes{ data: { class: 'emphasis' } }
  %h3 PageRank Panda Update
  %p Don't mess with Google. If you look at the charts below, you'll see websites that were penalized during the February 2011 Panda update.
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
  %br/
  %ul
    %li Make sure Google is aware of all of your content.
    %li Make sure your content is well-structured and provides value to the user.
    %li Use best practices in building your content.
    %li Keep your website clean and fast.
    %li Don't try to game their system.

  %p Google cares more about the user than they do about you. If you're doing something to get visits and the user isn't obtaining value, Google will know. 
  %p Metrics such as bounce-rates and average time spent on website will play into your rankings.

@@ slide14
#content
  %h1 Developers vs. Product
  %h2 Whose job is it?
#notes{ data: { class: 'alternate' } }
  %h1 PRODUCT!
  %br/
  %br/
  %p Just kidding...

@@ slide15
#content
  %h1.center.extra-large SEO
  %h2.center A Team Effort

@@ slide16
#content
  %h2 Product's Role
  %p Build for the user and infuse SEO. Don't approach it from the wrong way - the user should always come first.
  %ul
    %li 
      %b Define & communicate keywords
      \ - Determining what keywords perform best for us and communicate them to the team so we know what meta information to focus on (i.e. page titles, meta descriptions, alt tags, etc.).
    %li 
      %b URL Naming
      \ - Take them serious! Grab a dev and bounce ideas off of them. When we change a URL at a later date, it hurts our SEO juice. 10k backlinks to /store is better than 5k backlinks to /items and 5k backlinks to /store. Think about it.
    %li 
      %b Sitemaps
      \ - Are we adding a new feature? Make sure it's added to the HTML sitemap. Make sure we have FAQ content in place.
    %li 
      %b Feature flows
      \ - Does the feature flow smoothly? Is it organized? Is there a hierarchy? Can it be intertwined with another feature (i.e. Catalog) on our website?
    %li 
      %b Quality content 
      \- The copy/content on a page matters. Copy and pasting is the devil for SEO. Be creative, take your time, and make it count.
    %li 
      %b Don't be shady! 
      \- Google doesn't like it. Developers don't like it. It feels dirty-all-over to code something that does not benefit the user and has negative, ulterior motives. 

@@ slide17
#content
  %h2 Developer's Role
  %p Get educated! Not knowing is not an excuse!
  %ul
    %li 
      %b Don't be lazy
      \ - Have an image? Make sure there's alt text. Have a link? Make sure there's title text. Use the right elements (h1, h2, p, etc.).
    %li 
      %b Think hard on the meta
      \ - When you place the alt text, make it meaningful. If you care, you'll take the time to do it right.
    %li 
      %b Plan from the beginning 
      \- Before you start coding, think about SEO. SEO can dictate execution (i.e. don't bring content in via AJAX).
    %li
      %b JavaScript beware
      \ - If a link requires jQuery to work, you're doing it wrong. If a bot can't get from page to page, you're doing it wrong. 
    %li 
      %b Don't be shady! 
      \- We're an ethical company. It something doesn't feel right, speakUP, but be respectful and rational.

#notes{ data: { class: 'emphasis' } }
  %h3 Proper HTML Attributes
  %p 
    Bad:
    %br/
    ~load_snippet('bad_image_tag.html')

  %p 
    Good:
    %br/
    ~load_snippet('good_image_tag.html')

  %p 
    Bad:
    %br/
    ~load_snippet('bad_anchor_tag.html')

  %p 
    Good:
    %br/
    ~load_snippet('good_anchor_tag.html')

  %p Seems small, but if you extrapolate it out to 40,000 links and images, the benefits are significant. Alt and title tags provide Google with context of the links and images you have listed on your website (when you have an image, Google doesn't know what it is without the alt tag).

@@ slide18
#content
  %h1.center.extra-large SEO
  %h2.center What's Next?

@@ slide19
#content
  %h2 Focus-a-thon
  %h3 There's a lot we need to do.
  %ul
    %li Re-build HTML and XML sitemaps.
    %li Keyword meta information audit.
    %li Developer HTML attribute audit.
    %li Status codes and re-direct audit.
    %li JavaScript audit.
    %li URL schemes audit.
    %li Hierarchy link mapping.

  %p We need to update our catalog and SIV to have descriptive back links so that bots can traverse to end nodes (single item views) and work their way back up to root nodes (brand catalog, size catalog, category catalog).

@@ slide20
#content
  %h2 What else can we do?
  %ul
    %li Expand the FAQ - If we get asked a question a lot (i.e. quality), write a full blog post addressing the issue and link to it from the FAQ.
    %li Create more customized Google product feeds.
    %li Investigate how to improve our Yahoo/Bing ranking and implement best practices.
    %li Introduce the HTML canonical attribute to our store, catalog, and bag feed links.
    %li Mobile App SEO (ex: blog about app updates/releases/features).
    %li Quality, used kids clothes-related content creation (how about some education on the used kids clothing market?).
    %li Optimize page speed further on entry points.

@@ slide21
#content
  %h2 Parting words
  %br/
  %ul.large
    %li SEO gains won't be seen overnight, but the sooner we address it the better. 
    %li Having a sound SEO foundation in place will be critical as we scale.
    %li Focus on what we can plausibly win (i.e. long-tail brand/category keywords).
    %li Everyone 'owns' SEO - all ideas are welcome.

#notes{ data: { class: 'alternate' } }
  %p As Captain Planet says:
  %h1.small With SEO
  %img{src: '/images/captain_planet.jpeg'}
  %h1.small The power is yours!
