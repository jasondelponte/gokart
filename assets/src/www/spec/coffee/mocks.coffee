
modLoader.define 'mocks', (require, exports)->

  exports.ajax = jasmine.createSpy('AJAX Stub').andCallFake () ->
    return

  exports.model_subreddit = {
    id:'fake id',
    title:'fake title',
    name:'fake name'
    url: '/r/programming/'
  }

  exports.rsp_reddits = {
    "kind":"Listing",
    "data":{
      "modhash":"yqpsudqtcv91b6a8e81dcce79d45fcaf82bfc6b147f7fab330",
      "children":[
        {
          "kind":"t5",
          "data":{
            "display_name":"pics",
            "name":"t5_2qh0u",
            "title":"Pictures and Images",
            "url":"/r/pics/",
            "created":1201221069.0,
            "created_utc":1201221069.0,
            "over18":false,
            "subscribers":1098672,
            "id":"2qh0u",
            "description":"A place to share interesting photographs and pictures. Feel free to post your own, but please **read the rules first** (see below), and note that we are *not a catch-all* for general images (of text, comics, etc.)\n\n\n#Announcement#\n*Oct 13th, 2011* - **We have a [new ruleset](http://www.reddit.com/r/pics/comments/lb24q/rpics_ruleset/)**, please read it carefully  before submitting anything. \n\n#Rules#\n\n1. **No pictures of text.** *This includes images with superimposed text, such as [image macros](http://en.wikipedia.org/wiki/Image_macro) and comics, as well as screenshots, and (non-historical) handwritten text.*\n\n1. **No gore, porn or anything NSFW.** *This subreddit is strictly SFW, and there are better places for such content.*\n\n1. **No personal information.** *This includes anything hosted on Facebook's servers, as they can be traced to the original account holder. Stalking &amp; harassment will not be tolerated.*\n\n1. **No solicitation of votes or DAE posts.** \n\n1. **No non-author URLs in images.** *We only tolerate URLs in images if they serve to give credit to the original author.*\n\n**Please also read the full version of these rules [here](http://www.reddit.com/r/pics/comments/lb24q/rpics_ruleset/).**\n\n\nIf your submission appears to be banned but meets the above rules, [please send us a message](/message/compose?to=%23pics). Don't delete it  as that makes the filter hate you! \n\n\nIf you come across any rule violations,  please report the submission or  [message the mods](http://www.reddit.com/message/compose?to=%23pics) and one of us will remove it!\n\n#Related subreddits#\n\n* **[misc](/r/misc/)**\n* **[gifs](/r/gifs/)**\n* **[f7u12](/r/fffffffuuuuuuuuuuuu/)**\n* **[Vertical](/r/Vertical)**\n* **[Demotivational](/r/Demotivational)**\n* **[Advice Animals](/r/AdviceAnimals)**\n* **[The SFWPorn Network](http://reddit.com/r/earthporn+villageporn+cityporn+spaceporn+waterporn+abandonedporn+animalporn+humanporn+botanicalporn+adrenalineporn+destructionporn+movieposterporn+albumartporn+machineporn+newsporn+geekporn+bookporn+mapporn+adporn+designporn+roomporn+militaryporn+historyporn+quotesporn+skyporn+fireporn+infrastructureporn)**\n* [Rage Novels](/r/ragenovels/)\n* [Rage Ops](/r/rageops)\n* [Advice Atheists](/r/AdviceAtheists)\n* [a6theism10](/r/aaaaaatheismmmmmmmmmm)\n* [Trolling Animals](/r/TrollingAnimals)\n* [/r/AnythingGoesPics](/r/AnythingGoesPics)\n* [/r/OriginalHub](/r/OriginalHub)\n* [/r/screenshots](/r/screenshots)\n* [/r/tradingfaces](/r/tradingfaces)\n* [/r/nostalgia](/r/nostalgia)\n* [/r/facepalm](/r/facepalm)\n* [/r/gamingpics](/r/gamingpics)\n* [/r/aww](/r/aww)\n* [/r/eCards](/r/eCards)\n* [/r/comics](/r/comics)\n* [/r/webcomics](/r/webcomics)\n* [/r/photography](/r/photography)\n* [/r/PictureChallenge](/r/PictureChallenge)\n* [/r/photocritique](/r/photocritique)\n* [/r/windowshots](/r/windowshots)\n* [/r/wallpaper](/r/wallpaper)\n* [/r/wallpapers](/r/wallpapers)\n* [/r/1000words](/r/1000words)\n* [/r/newreddits](/r/newreddits)\n\nAlso check out http://irc.reddit.com\n\n### [***20/10/11 New Ruleset***: Please report violations using the 'report' button.](http://www.reddit.com/r/pics/comments/lb24q/rpics_ruleset/)###"
          }
        },
        {
          "kind":"t5",
          "data":{
            "display_name":"funny",
            "name":"t5_2qh33",
            "title":"funny",
            "url":"/r/funny/",
            "created":1201242956.0,
            "created_utc":1201242956.0,
            "over18":false,
            "subscribers":1111900,
            "id":"2qh33",
            "description":"***New Rule***: No posts with their sole purpose being to communicate with another redditor. [Example.](http://www.reddit.com/r/funny/comments/lq3uv/a_student_in_a_course_i_teach_is_constantly/) Sorry, you're going to have to use a different form of communication.\n\n---\n\n1. [**New r/Funny Rule**, click here to see.](http://www.reddit.com/r/funny/comments/lqgx7/new_rule_use_your_phone_or_something/)\n\n**Welcome to r/Funny:**\n\nYou may only post if you are funny. \n\nNo rage comics. Go to [/F7U12](http://www.reddit.com/r/fffffffuuuuuuuuuuuu) instead.\n\n**No Memes!** Go to [/AdviceAnimals](/r/adviceanimals) instead.\n\nRehosted webcomics will be removed. Please submit a link to the original comic's site and preferably an imgur link in the comments. [(*)](http://www.reddit.com/r/funny/comments/kqwwx/we_need_to_talk_about_rehosting_wecomics/)\n\nBefore you submit a screenshot of a reddit thread *here*, you might want to check out [r/BestOf](http://www.reddit.com/r/bestof). \n\nNeed more? Check out:\n\n* [humor](http://www.reddit.com/r/humor) for more in-depth stuff\n* [jokes](/r/jokes)\n* [comics](/r/comics)\n* [punny](/r/punny)\n* [Very Punny](/r/verypunny)\n* [lolcats](/r/lolcats)\n* [lol](/r/lol)\n* [TrollingAnimals](/r/TrollingAnimals)\n* [Rage Novels](/r/ragenovels/)\n* [Demotivational](http://www.reddit.com/r/Demotivational)\n* **[misc](/r/misc/)** for anything else\n\nStill need more? See Reddit's [best / worst](http://www.reddit.com/r/AskReddit/comments/8ft5j/tell_me_your_best_worst_joke_reddit/?sort=top) and [offensive](http://www.reddit.com/r/funny/comments/7rxyh/collection_of_totally_offensive_jokes_not_for_the/?sort=top) joke collections (warning: some of those jokes are offensive / nsfw!). \n\n\n------\n\nPlease DO NOT post [personal information](http://www.reddit.com/help/faq#Ispostingpersonalinformationok). This includes anything hosted on Facebook's servers, as they can be traced to the original account holder.\n\n----\n\nIf your submission appears to be banned, please don't just delete it as that makes the filter hate you! Instead please [send us a message](/message/compose?to=%23funny). We'll unban it and it should get better. please allow 10 minutes for the post to appear before messaging moderators\n\n----\n\nCSS - BritishEnglishPolice \u00a92011"
          }
        }
      ],
      "after":"t5_2qq5c",
      "before":null
    }
  }

  exports.rsp_posts = {
    "kind":"Listing",
    "data":{
      "modhash":"s7069nuzol41d61f1b1ff780c40b025a4848c4b06c6ebaa061",
      "children":[
        {
          "kind":"t3",
          "data":{
            "domain":"perlbuzz.com",
            "media_embed":{

            },
            "levenshtein":null,
            "subreddit":"programming",
            "selftext_html":null,
            "selftext":"",
            "likes":null,
            "saved":false,
            "id":"ms13h",
            "clicked":false,
            "title":"Finding a lost dog's owner with Perl",
            "media":null,
            "score":426,
            "over_18":false,
            "hidden":false,
            "thumbnail":"",
            "subreddit_id":"t5_2fwo",
            "author_flair_css_class":null,
            "downs":222,
            "is_self":false,
            "permalink":"/r/programming/comments/ms13h/finding_a_lost_dogs_owner_with_perl/",
            "name":"t3_ms13h",
            "created":1322517472.0,
            "url":"http://perlbuzz.com/2011/11/finding-a-lost-dogs-owner-with-perl-and-wwwmechanize.html",
            "author_flair_text":null,
            "author":"mpeters",
            "created_utc":1322492272.0,
            "num_comments":61,
            "ups":648
          }
        },
        {
          "kind":"t3",
          "data":{
            "domain":"elegantcoding.com",
            "media_embed":{

            },
            "levenshtein":null,
            "subreddit":"programming",
            "selftext_html":null,
            "selftext":"",
            "likes":null,
            "saved":false,
            "id":"msl7x",
            "clicked":false,
            "title":"Eleven equations every Computer Science geeks should know",
            "media":null,
            "score":76,
            "over_18":false,
            "hidden":false,
            "thumbnail":"",
            "subreddit_id":"t5_2fwo",
            "author_flair_css_class":null,
            "downs":41,
            "is_self":false,
            "permalink":"/r/programming/comments/msl7x/eleven_equations_every_computer_science_geeks/",
            "name":"t3_msl7x",
            "created":1322547476.0,
            "url":"http://www.elegantcoding.com/2011/11/eleven-equations-true-computer-science.html",
            "author_flair_text":null,
            "author":"chandershivdasani",
            "created_utc":1322522276.0,
            "num_comments":34,
            "ups":117
          }
        }
      ],
      "after":"t3_mqs0s",
      "before":null
    }
  }
  return