<!DOCTYPE html>
<html lang="en">
<head>
  <meta id="bb-bootstrap" data-current-user="{&quot;username&quot;: &quot;vchaplin&quot;, &quot;displayName&quot;: &quot;vchaplin&quot;, &quot;uuid&quot;: &quot;{3ece6e98-c567-45f5-a3fa-a84b660917ee}&quot;, &quot;firstName&quot;: &quot;vchaplin&quot;, &quot;hasPremium&quot;: false, &quot;lastName&quot;: &quot;&quot;, &quot;avatarUrl&quot;: &quot;https://bitbucket.org/account/vchaplin/avatar/32/?ts=1501171225&quot;, &quot;isTeam&quot;: false, &quot;isSshEnabled&quot;: false, &quot;isKbdShortcutsEnabled&quot;: true, &quot;id&quot;: 2332917, &quot;isAuthenticated&quot;: true}"
data-atlassian-id="557058:8085dfdf-6e0a-446a-a63b-de16571b5502" />
  
  
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta charset="utf-8">
  <title>
  vchaplin / HiFU 
  / source  / code / myPy / numpy.i
 &mdash; Bitbucket
</title>
  <script type="text/javascript">window.NREUM||(NREUM={}),__nr_require=function(e,n,t){function r(t){if(!n[t]){var o=n[t]={exports:{}};e[t][0].call(o.exports,function(n){var o=e[t][1][n];return r(o||n)},o,o.exports)}return n[t].exports}if("function"==typeof __nr_require)return __nr_require;for(var o=0;o<t.length;o++)r(t[o]);return r}({1:[function(e,n,t){function r(){}function o(e,n,t){return function(){return i(e,[c.now()].concat(u(arguments)),n?null:this,t),n?void 0:this}}var i=e("handle"),a=e(2),u=e(3),f=e("ee").get("tracer"),c=e("loader"),s=NREUM;"undefined"==typeof window.newrelic&&(newrelic=s);var p=["setPageViewName","setCustomAttribute","setErrorHandler","finished","addToTrace","inlineHit","addRelease"],d="api-",l=d+"ixn-";a(p,function(e,n){s[n]=o(d+n,!0,"api")}),s.addPageAction=o(d+"addPageAction",!0),s.setCurrentRouteName=o(d+"routeName",!0),n.exports=newrelic,s.interaction=function(){return(new r).get()};var m=r.prototype={createTracer:function(e,n){var t={},r=this,o="function"==typeof n;return i(l+"tracer",[c.now(),e,t],r),function(){if(f.emit((o?"":"no-")+"fn-start",[c.now(),r,o],t),o)try{return n.apply(this,arguments)}finally{f.emit("fn-end",[c.now()],t)}}}};a("setName,setAttribute,save,ignore,onEnd,getContext,end,get".split(","),function(e,n){m[n]=o(l+n)}),newrelic.noticeError=function(e){"string"==typeof e&&(e=new Error(e)),i("err",[e,c.now()])}},{}],2:[function(e,n,t){function r(e,n){var t=[],r="",i=0;for(r in e)o.call(e,r)&&(t[i]=n(r,e[r]),i+=1);return t}var o=Object.prototype.hasOwnProperty;n.exports=r},{}],3:[function(e,n,t){function r(e,n,t){n||(n=0),"undefined"==typeof t&&(t=e?e.length:0);for(var r=-1,o=t-n||0,i=Array(o<0?0:o);++r<o;)i[r]=e[n+r];return i}n.exports=r},{}],4:[function(e,n,t){n.exports={exists:"undefined"!=typeof window.performance&&window.performance.timing&&"undefined"!=typeof window.performance.timing.navigationStart}},{}],ee:[function(e,n,t){function r(){}function o(e){function n(e){return e&&e instanceof r?e:e?f(e,u,i):i()}function t(t,r,o,i){if(!d.aborted||i){e&&e(t,r,o);for(var a=n(o),u=m(t),f=u.length,c=0;c<f;c++)u[c].apply(a,r);var p=s[y[t]];return p&&p.push([b,t,r,a]),a}}function l(e,n){v[e]=m(e).concat(n)}function m(e){return v[e]||[]}function w(e){return p[e]=p[e]||o(t)}function g(e,n){c(e,function(e,t){n=n||"feature",y[t]=n,n in s||(s[n]=[])})}var v={},y={},b={on:l,emit:t,get:w,listeners:m,context:n,buffer:g,abort:a,aborted:!1};return b}function i(){return new r}function a(){(s.api||s.feature)&&(d.aborted=!0,s=d.backlog={})}var u="nr@context",f=e("gos"),c=e(2),s={},p={},d=n.exports=o();d.backlog=s},{}],gos:[function(e,n,t){function r(e,n,t){if(o.call(e,n))return e[n];var r=t();if(Object.defineProperty&&Object.keys)try{return Object.defineProperty(e,n,{value:r,writable:!0,enumerable:!1}),r}catch(i){}return e[n]=r,r}var o=Object.prototype.hasOwnProperty;n.exports=r},{}],handle:[function(e,n,t){function r(e,n,t,r){o.buffer([e],r),o.emit(e,n,t)}var o=e("ee").get("handle");n.exports=r,r.ee=o},{}],id:[function(e,n,t){function r(e){var n=typeof e;return!e||"object"!==n&&"function"!==n?-1:e===window?0:a(e,i,function(){return o++})}var o=1,i="nr@id",a=e("gos");n.exports=r},{}],loader:[function(e,n,t){function r(){if(!x++){var e=h.info=NREUM.info,n=d.getElementsByTagName("script")[0];if(setTimeout(s.abort,3e4),!(e&&e.licenseKey&&e.applicationID&&n))return s.abort();c(y,function(n,t){e[n]||(e[n]=t)}),f("mark",["onload",a()+h.offset],null,"api");var t=d.createElement("script");t.src="https://"+e.agent,n.parentNode.insertBefore(t,n)}}function o(){"complete"===d.readyState&&i()}function i(){f("mark",["domContent",a()+h.offset],null,"api")}function a(){return E.exists&&performance.now?Math.round(performance.now()):(u=Math.max((new Date).getTime(),u))-h.offset}var u=(new Date).getTime(),f=e("handle"),c=e(2),s=e("ee"),p=window,d=p.document,l="addEventListener",m="attachEvent",w=p.XMLHttpRequest,g=w&&w.prototype;NREUM.o={ST:setTimeout,SI:p.setImmediate,CT:clearTimeout,XHR:w,REQ:p.Request,EV:p.Event,PR:p.Promise,MO:p.MutationObserver};var v=""+location,y={beacon:"bam.nr-data.net",errorBeacon:"bam.nr-data.net",agent:"js-agent.newrelic.com/nr-1044.min.js"},b=w&&g&&g[l]&&!/CriOS/.test(navigator.userAgent),h=n.exports={offset:u,now:a,origin:v,features:{},xhrWrappable:b};e(1),d[l]?(d[l]("DOMContentLoaded",i,!1),p[l]("load",r,!1)):(d[m]("onreadystatechange",o),p[m]("onload",r)),f("mark",["firstbyte",u],null,"api");var x=0,E=e(4)},{}]},{},["loader"]);</script>
  


<meta id="bb-canon-url" name="bb-canon-url" content="https://bitbucket.org">
<meta name="bb-api-canon-url" content="https://api.bitbucket.org">
<meta name="apitoken" content="{&quot;token&quot;: &quot;dMJ8AYysgz4O08ZhgBeeMGEoBRUAoJ7sqC5LuV07hVaUjymQmjUpQGN_KazEkKmXgs0rRzfeliXrTBHNyjG134HUJAAUs3C9vw==&quot;, &quot;connectionId&quot;: 619065, &quot;expiration&quot;: 1501178355.172127}">

<meta name="bb-commit-hash" content="d47e46547a06">
<meta name="bb-app-node" content="app-167">
<meta name="bb-view-name" content="bitbucket.apps.repo2.views.filebrowse">
<meta name="ignore-whitespace" content="False">
<meta name="tab-size" content="None">
<meta name="locale" content="en">

<meta name="application-name" content="Bitbucket">
<meta name="apple-mobile-web-app-title" content="Bitbucket">
<meta name="theme-color" content="#205081">
<meta name="msapplication-TileColor" content="#205081">
<meta name="msapplication-TileImage" content="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/img/logos/bitbucket/white-256.png">
<link rel="apple-touch-icon" sizes="192x192" type="image/png" href="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/img/bitbucket_avatar/192/bitbucket.png">
<link rel="icon" sizes="192x192" type="image/png" href="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/img/bitbucket_avatar/192/bitbucket.png">
<link rel="icon" sizes="16x16 32x32" type="image/x-icon" href="/favicon.ico">
<link rel="search" type="application/opensearchdescription+xml" href="/opensearch.xml" title="Bitbucket">
  <meta name="description" content="">
  
  
    
  



  <link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/css/entry/vendor.css" />
<link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/css/entry/app.css" />




  <link rel="stylesheet" href="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/css/entry/adg3.css">

  
  <script nonce="CMqjSUUZf83A8MTx">
  window.__sentry__ = {"dsn": "https://ea49358f525d4019945839a3d7a8292a@sentry.io/159509", "release": "d47e46547a06 (production)", "tags": {"project": "bitbucket-core"}, "environment": "production"};
</script>
<script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/dist/webpack/sentry.js"></script>
  <script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/dist/webpack/early.js"></script>
  
  
    <link href="/vchaplin/hifu/rss?token=bb45e16a8d7eac58182532f5bbf015f7" rel="alternate nofollow" type="application/rss+xml" title="RSS feed for HiFU" />

</head>
<body class="production adg3 "
    data-static-url="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/"
data-base-url="https://bitbucket.org"
data-no-avatar-image="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/img/default_avatar/user_blue.svg"
data-current-user="{&quot;username&quot;: &quot;vchaplin&quot;, &quot;displayName&quot;: &quot;vchaplin&quot;, &quot;uuid&quot;: &quot;{3ece6e98-c567-45f5-a3fa-a84b660917ee}&quot;, &quot;firstName&quot;: &quot;vchaplin&quot;, &quot;hasPremium&quot;: false, &quot;lastName&quot;: &quot;&quot;, &quot;avatarUrl&quot;: &quot;https://bitbucket.org/account/vchaplin/avatar/32/?ts=1501171225&quot;, &quot;isTeam&quot;: false, &quot;isSshEnabled&quot;: false, &quot;isKbdShortcutsEnabled&quot;: true, &quot;id&quot;: 2332917, &quot;isAuthenticated&quot;: true}"
data-atlassian-id="{&quot;loginStatusUrl&quot;: &quot;https://id.atlassian.com/profile/rest/profile&quot;}"
data-settings="{&quot;MENTIONS_MIN_QUERY_LENGTH&quot;: 3}"

data-current-repo="{&quot;scm&quot;: &quot;git&quot;, &quot;readOnly&quot;: false, &quot;mainbranch&quot;: {&quot;name&quot;: &quot;master&quot;}, &quot;language&quot;: &quot;&quot;, &quot;owner&quot;: {&quot;username&quot;: &quot;vchaplin&quot;, &quot;uuid&quot;: &quot;3ece6e98-c567-45f5-a3fa-a84b660917ee&quot;, &quot;isTeam&quot;: false}, &quot;fullslug&quot;: &quot;vchaplin/hifu&quot;, &quot;slug&quot;: &quot;hifu&quot;, &quot;id&quot;: 8608639, &quot;pygmentsLanguage&quot;: null}"
data-current-cset="a6eab5db0d6764b6de7a9f2069e4474a3c404761"





data-browser-monitoring="true"
data-switch-create-pullrequest-commit-status="true"

data-track-js-errors="true"


>
<div id="page">
  
    
      <div id="adg3-navigation"
  
  
  
  >
  <nav class="skeleton-nav">
    <div class="skeleton-nav--left">
      <div class="skeleton-nav--left-top">
        <ul class="skeleton-nav--items">
          <li></li>
          <li></li>
          <li></li>
          <li class="skeleton--icon"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
          <li class="skeleton--icon-sub"></li>
        </ul>
      </div>
      <div class="skeleton-nav--left-bottom">
        <div class="skeleton-nav--left-bottom-wrapper">
          <div class="skeleton-nav--item-help"></div>
          <div class="skeleton-nav--item-profile"></div>
        </div>
      </div>
    </div>
    <div class="skeleton-nav--right">
      <ul class="skeleton-nav--items-wide">
        <li class="skeleton--icon-logo-container">
          <div class="skeleton--icon-container"></div>
          <div class="skeleton--icon-description"></div>
          <div class="skeleton--icon-logo"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
        <li>
          <div class="skeleton--icon-small"></div>
          <div class="skeleton-nav--item-wide-content"></div>
        </li>
      </ul>
    </div>
  </nav>
</div>


    
    <div id="wrapper">
      
  


      

      
  
    <div id="nps-survey-container"></div>
  


      
  

<div id="account-warning" data-module="header/account-warning"
  data-unconfirmed-addresses="false"
  data-no-addresses="false"
  
></div>



      
  
<header id="aui-message-bar">
  
</header>


    <div id="content" role="main">
      
        
          <header class="app-header">
            <div class="app-header--primary">
              
                <div class="app-header--context">
                  <div class="app-header--breadcrumbs">
                    
            <ol class="aui-nav aui-nav-breadcrumbs">
              <li>
  <a href="/vchaplin/">vchaplin</a>
</li>

<li>
  <a href="/vchaplin/hifu">HiFU</a>
</li>
              
            </ol>
          
                  </div>
                  <h1 class="app-header--heading">
                    Source
                  </h1>
                </div>
                
              </div>
              <div class="app-header--secondary">
                
                  
                
              </div>
            </header>
          
        
        
  

        
  <div class="aui-page-panel ">
    <div class="hidden">
  
  </div>
    <div class="aui-page-panel-inner">

      <div
        id="repo-content"
        class="aui-page-panel-content forks-enabled can-create"
        data-module="repo/index"
        
      >
        
        
  <div id="source-container" class="maskable" data-module="repo/source/index">
    



<header id="source-path">
  
    <div class="labels labels-csv">
      <div class="aui-buttons">
        <button data-branches-tags-url="/api/1.0/repositories/vchaplin/hifu/branches-tags"
                data-module="components/branch-dialog"
                
                class="aui-button branch-dialog-trigger" title="master">
          
            
              <span class="aui-icon aui-icon-small aui-iconfont-devtools-branch">Branch</span>
            
            <span class="name">master</span>
          
          <span class="aui-icon-dropdown"></span>
        </button>
        <button class="aui-button" id="checkout-branch-button"
                title="Check out this branch">
          <span class="aui-icon aui-icon-small aui-iconfont-devtools-clone">Check out branch</span>
          <span class="aui-icon-dropdown"></span>
        </button>
      </div>
      
    
    
  
    </div>
  
  
    <div class="secondary-actions">
      <div class="aui-buttons">
        
          <a href="/vchaplin/hifu/src/a6eab5db0d67/code/myPy/numpy.i?at=master"
            class="aui-button pjax-trigger source-toggle" aria-pressed="true">
            Source
          </a>
          <a href="/vchaplin/hifu/diff/code/myPy/numpy.i?diff2=a6eab5db0d67&at=master"
            class="aui-button pjax-trigger diff-toggle"
            title="Diff to previous change">
            Diff
          </a>
          <a href="/vchaplin/hifu/history-node/a6eab5db0d67/code/myPy/numpy.i?at=master"
            class="aui-button pjax-trigger history-toggle">
            History
          </a>
        
      </div>
    </div>
  
  <h1>
    
      
        <a href="/vchaplin/hifu/src/a6eab5db0d67?at=master"
          class="pjax-trigger root" title="vchaplin/hifu at a6eab5db0d67">HiFU</a> /
      
      
        
          
            <a href="/vchaplin/hifu/src/a6eab5db0d67/code/?at=master"
              class="pjax-trigger directory-name">code</a> /
          
        
      
        
          
            <a href="/vchaplin/hifu/src/a6eab5db0d67/code/myPy/?at=master"
              class="pjax-trigger directory-name">myPy</a> /
          
        
      
        
          
            <span class="file-name">numpy.i</span>
          
        
      
    
  </h1>
  
    
    
  
  <div class="clearfix"></div>
</header>


  
    
  

  <div id="editor-container" class="maskable"
       data-module="repo/source/editor"
       data-owner="vchaplin"
       data-slug="hifu"
       data-is-writer="true"
       data-has-push-access="true"
       data-hash="a6eab5db0d6764b6de7a9f2069e4474a3c404761"
       data-branch="master"
       data-path="code/myPy/numpy.i"
       data-source-url="/api/internal/repositories/vchaplin/hifu/src/a6eab5db0d6764b6de7a9f2069e4474a3c404761/code/myPy/numpy.i">
    <div id="source-view" class="file-source-container" data-module="repo/source/view-file" data-is-lfs="false">
      <div class="toolbar">
        <div class="primary">
          <div class="aui-buttons">
            
              <button id="file-history-trigger" class="aui-button aui-button-light changeset-info"
                      data-changeset="a6eab5db0d6764b6de7a9f2069e4474a3c404761"
                      data-path="code/myPy/numpy.i"
                      data-current="a6eab5db0d6764b6de7a9f2069e4474a3c404761">
                 

  <div class="aui-avatar aui-avatar-xsmall">
    <div class="aui-avatar-inner">
      <img src="https://bitbucket.org/account/vchaplin/avatar/16/?ts=1501171225">
    </div>
  </div>
  <span class="changeset-hash">a6eab5d</span>
  <time datetime="2017-07-11T14:56:41+00:00" class="timestamp"></time>
  <span class="aui-icon-dropdown"></span>

              </button>
            
          </div>
          
          <a href="/vchaplin/hifu/full-commit/a6eab5db0d67/code/myPy/numpy.i" id="full-commit-link"
             title="View full commit a6eab5d">Full commit</a>
        </div>
        <div class="secondary">
          
          <div class="aui-buttons">
            
              <a href="/vchaplin/hifu/annotate/a6eab5db0d6764b6de7a9f2069e4474a3c404761/code/myPy/numpy.i?at=master"
                 class="aui-button aui-button-light pjax-trigger blame-link">Blame</a>
              
            
            <a href="/vchaplin/hifu/raw/a6eab5db0d6764b6de7a9f2069e4474a3c404761/code/myPy/numpy.i" class="aui-button aui-button-light raw-link">Raw</a>
          </div>
          
            <div class="aui-buttons">
              
              <button id="file-edit-button" class="edit-button aui-button aui-button-light aui-button-split-main"
                  >
                Edit
                
              </button>
              <button id="file-more-actions-button" class="aui-button aui-button-light aui-dropdown2-trigger aui-button-split-more" aria-owns="split-container-dropdown" aria-haspopup="true"
                  >
                More file actions
              </button>
            </div>
            <div id="split-container-dropdown" class="aui-dropdown2 aui-style-default" data-container="#editor-container">
              <ul class="aui-list-truncate">
                <li><a href="#" data-module="repo/source/rename-file" class="rename-link">Rename</a></li>
                <li><a href="#" data-module="repo/source/delete-file" class="delete-link">Delete</a></li>
              </ul>
            </div>
          
        </div>

        <div id="fileview-dropdown"
            class="aui-dropdown2 aui-style-default"
            data-fileview-container="#fileview-container"
            
            
            data-fileview-button="#fileview-trigger"
            data-module="connect/fileview">
          <div class="aui-dropdown2-section">
            <ul>
              <li>
                <a class="aui-dropdown2-radio aui-dropdown2-checked"
                    data-fileview-id="-1"
                    data-fileview-loaded="true"
                    data-fileview-target="#fileview-original"
                    data-fileview-connection-key=""
                    data-fileview-module-key="file-view-default">
                  Default File Viewer
                </a>
              </li>
              
            </ul>
          </div>
        </div>

        <div class="clearfix"></div>
      </div>
      <div id="fileview-container">
        <div id="fileview-original"
            class="fileview"
            data-module="repo/source/highlight-lines"
            data-fileview-loaded="true">
          


  
    <div class="file-source">
      <table class="highlighttable">
<tr><td class="linenos"><div class="linenodiv"><pre>
<a href="#numpy.i-1">1</a>
<a href="#numpy.i-2">2</a>
<a href="#numpy.i-3">3</a>
<a href="#numpy.i-4">4</a>
<a href="#numpy.i-5">5</a>
<a href="#numpy.i-6">6</a>
<a href="#numpy.i-7">7</a>
<a href="#numpy.i-8">8</a>
<a href="#numpy.i-9">9</a>
<a href="#numpy.i-10">10</a>
<a href="#numpy.i-11">11</a>
<a href="#numpy.i-12">12</a>
<a href="#numpy.i-13">13</a>
<a href="#numpy.i-14">14</a>
<a href="#numpy.i-15">15</a>
<a href="#numpy.i-16">16</a>
<a href="#numpy.i-17">17</a>
<a href="#numpy.i-18">18</a>
<a href="#numpy.i-19">19</a>
<a href="#numpy.i-20">20</a>
<a href="#numpy.i-21">21</a>
<a href="#numpy.i-22">22</a>
<a href="#numpy.i-23">23</a>
<a href="#numpy.i-24">24</a>
<a href="#numpy.i-25">25</a>
<a href="#numpy.i-26">26</a>
<a href="#numpy.i-27">27</a>
<a href="#numpy.i-28">28</a>
<a href="#numpy.i-29">29</a>
<a href="#numpy.i-30">30</a>
<a href="#numpy.i-31">31</a>
<a href="#numpy.i-32">32</a>
<a href="#numpy.i-33">33</a>
<a href="#numpy.i-34">34</a>
<a href="#numpy.i-35">35</a>
<a href="#numpy.i-36">36</a>
<a href="#numpy.i-37">37</a>
<a href="#numpy.i-38">38</a>
<a href="#numpy.i-39">39</a>
<a href="#numpy.i-40">40</a>
<a href="#numpy.i-41">41</a>
<a href="#numpy.i-42">42</a>
<a href="#numpy.i-43">43</a>
<a href="#numpy.i-44">44</a>
<a href="#numpy.i-45">45</a>
<a href="#numpy.i-46">46</a>
<a href="#numpy.i-47">47</a>
<a href="#numpy.i-48">48</a>
<a href="#numpy.i-49">49</a>
<a href="#numpy.i-50">50</a>
<a href="#numpy.i-51">51</a>
<a href="#numpy.i-52">52</a>
<a href="#numpy.i-53">53</a>
<a href="#numpy.i-54">54</a>
<a href="#numpy.i-55">55</a>
<a href="#numpy.i-56">56</a>
<a href="#numpy.i-57">57</a>
<a href="#numpy.i-58">58</a>
<a href="#numpy.i-59">59</a>
<a href="#numpy.i-60">60</a>
<a href="#numpy.i-61">61</a>
<a href="#numpy.i-62">62</a>
<a href="#numpy.i-63">63</a>
<a href="#numpy.i-64">64</a>
<a href="#numpy.i-65">65</a>
<a href="#numpy.i-66">66</a>
<a href="#numpy.i-67">67</a>
<a href="#numpy.i-68">68</a>
<a href="#numpy.i-69">69</a>
<a href="#numpy.i-70">70</a>
<a href="#numpy.i-71">71</a>
<a href="#numpy.i-72">72</a>
<a href="#numpy.i-73">73</a>
<a href="#numpy.i-74">74</a>
<a href="#numpy.i-75">75</a>
<a href="#numpy.i-76">76</a>
<a href="#numpy.i-77">77</a>
<a href="#numpy.i-78">78</a>
<a href="#numpy.i-79">79</a>
<a href="#numpy.i-80">80</a>
<a href="#numpy.i-81">81</a>
<a href="#numpy.i-82">82</a>
<a href="#numpy.i-83">83</a>
<a href="#numpy.i-84">84</a>
<a href="#numpy.i-85">85</a>
<a href="#numpy.i-86">86</a>
<a href="#numpy.i-87">87</a>
<a href="#numpy.i-88">88</a>
<a href="#numpy.i-89">89</a>
<a href="#numpy.i-90">90</a>
<a href="#numpy.i-91">91</a>
<a href="#numpy.i-92">92</a>
<a href="#numpy.i-93">93</a>
<a href="#numpy.i-94">94</a>
<a href="#numpy.i-95">95</a>
<a href="#numpy.i-96">96</a>
<a href="#numpy.i-97">97</a>
<a href="#numpy.i-98">98</a>
<a href="#numpy.i-99">99</a>
<a href="#numpy.i-100">100</a>
<a href="#numpy.i-101">101</a>
<a href="#numpy.i-102">102</a>
<a href="#numpy.i-103">103</a>
<a href="#numpy.i-104">104</a>
<a href="#numpy.i-105">105</a>
<a href="#numpy.i-106">106</a>
<a href="#numpy.i-107">107</a>
<a href="#numpy.i-108">108</a>
<a href="#numpy.i-109">109</a>
<a href="#numpy.i-110">110</a>
<a href="#numpy.i-111">111</a>
<a href="#numpy.i-112">112</a>
<a href="#numpy.i-113">113</a>
<a href="#numpy.i-114">114</a>
<a href="#numpy.i-115">115</a>
<a href="#numpy.i-116">116</a>
<a href="#numpy.i-117">117</a>
<a href="#numpy.i-118">118</a>
<a href="#numpy.i-119">119</a>
<a href="#numpy.i-120">120</a>
<a href="#numpy.i-121">121</a>
<a href="#numpy.i-122">122</a>
<a href="#numpy.i-123">123</a>
<a href="#numpy.i-124">124</a>
<a href="#numpy.i-125">125</a>
<a href="#numpy.i-126">126</a>
<a href="#numpy.i-127">127</a>
<a href="#numpy.i-128">128</a>
<a href="#numpy.i-129">129</a>
<a href="#numpy.i-130">130</a>
<a href="#numpy.i-131">131</a>
<a href="#numpy.i-132">132</a>
<a href="#numpy.i-133">133</a>
<a href="#numpy.i-134">134</a>
<a href="#numpy.i-135">135</a>
<a href="#numpy.i-136">136</a>
<a href="#numpy.i-137">137</a>
<a href="#numpy.i-138">138</a>
<a href="#numpy.i-139">139</a>
<a href="#numpy.i-140">140</a>
<a href="#numpy.i-141">141</a>
<a href="#numpy.i-142">142</a>
<a href="#numpy.i-143">143</a>
<a href="#numpy.i-144">144</a>
<a href="#numpy.i-145">145</a>
<a href="#numpy.i-146">146</a>
<a href="#numpy.i-147">147</a>
<a href="#numpy.i-148">148</a>
<a href="#numpy.i-149">149</a>
<a href="#numpy.i-150">150</a>
<a href="#numpy.i-151">151</a>
<a href="#numpy.i-152">152</a>
<a href="#numpy.i-153">153</a>
<a href="#numpy.i-154">154</a>
<a href="#numpy.i-155">155</a>
<a href="#numpy.i-156">156</a>
<a href="#numpy.i-157">157</a>
<a href="#numpy.i-158">158</a>
<a href="#numpy.i-159">159</a>
<a href="#numpy.i-160">160</a>
<a href="#numpy.i-161">161</a>
<a href="#numpy.i-162">162</a>
<a href="#numpy.i-163">163</a>
<a href="#numpy.i-164">164</a>
<a href="#numpy.i-165">165</a>
<a href="#numpy.i-166">166</a>
<a href="#numpy.i-167">167</a>
<a href="#numpy.i-168">168</a>
<a href="#numpy.i-169">169</a>
<a href="#numpy.i-170">170</a>
<a href="#numpy.i-171">171</a>
<a href="#numpy.i-172">172</a>
<a href="#numpy.i-173">173</a>
<a href="#numpy.i-174">174</a>
<a href="#numpy.i-175">175</a>
<a href="#numpy.i-176">176</a>
<a href="#numpy.i-177">177</a>
<a href="#numpy.i-178">178</a>
<a href="#numpy.i-179">179</a>
<a href="#numpy.i-180">180</a>
<a href="#numpy.i-181">181</a>
<a href="#numpy.i-182">182</a>
<a href="#numpy.i-183">183</a>
<a href="#numpy.i-184">184</a>
<a href="#numpy.i-185">185</a>
<a href="#numpy.i-186">186</a>
<a href="#numpy.i-187">187</a>
<a href="#numpy.i-188">188</a>
<a href="#numpy.i-189">189</a>
<a href="#numpy.i-190">190</a>
<a href="#numpy.i-191">191</a>
<a href="#numpy.i-192">192</a>
<a href="#numpy.i-193">193</a>
<a href="#numpy.i-194">194</a>
<a href="#numpy.i-195">195</a>
<a href="#numpy.i-196">196</a>
<a href="#numpy.i-197">197</a>
<a href="#numpy.i-198">198</a>
<a href="#numpy.i-199">199</a>
<a href="#numpy.i-200">200</a>
<a href="#numpy.i-201">201</a>
<a href="#numpy.i-202">202</a>
<a href="#numpy.i-203">203</a>
<a href="#numpy.i-204">204</a>
<a href="#numpy.i-205">205</a>
<a href="#numpy.i-206">206</a>
<a href="#numpy.i-207">207</a>
<a href="#numpy.i-208">208</a>
<a href="#numpy.i-209">209</a>
<a href="#numpy.i-210">210</a>
<a href="#numpy.i-211">211</a>
<a href="#numpy.i-212">212</a>
<a href="#numpy.i-213">213</a>
<a href="#numpy.i-214">214</a>
<a href="#numpy.i-215">215</a>
<a href="#numpy.i-216">216</a>
<a href="#numpy.i-217">217</a>
<a href="#numpy.i-218">218</a>
<a href="#numpy.i-219">219</a>
<a href="#numpy.i-220">220</a>
<a href="#numpy.i-221">221</a>
<a href="#numpy.i-222">222</a>
<a href="#numpy.i-223">223</a>
<a href="#numpy.i-224">224</a>
<a href="#numpy.i-225">225</a>
<a href="#numpy.i-226">226</a>
<a href="#numpy.i-227">227</a>
<a href="#numpy.i-228">228</a>
<a href="#numpy.i-229">229</a>
<a href="#numpy.i-230">230</a>
<a href="#numpy.i-231">231</a>
<a href="#numpy.i-232">232</a>
<a href="#numpy.i-233">233</a>
<a href="#numpy.i-234">234</a>
<a href="#numpy.i-235">235</a>
<a href="#numpy.i-236">236</a>
<a href="#numpy.i-237">237</a>
<a href="#numpy.i-238">238</a>
<a href="#numpy.i-239">239</a>
<a href="#numpy.i-240">240</a>
<a href="#numpy.i-241">241</a>
<a href="#numpy.i-242">242</a>
<a href="#numpy.i-243">243</a>
<a href="#numpy.i-244">244</a>
<a href="#numpy.i-245">245</a>
<a href="#numpy.i-246">246</a>
<a href="#numpy.i-247">247</a>
<a href="#numpy.i-248">248</a>
<a href="#numpy.i-249">249</a>
<a href="#numpy.i-250">250</a>
<a href="#numpy.i-251">251</a>
<a href="#numpy.i-252">252</a>
<a href="#numpy.i-253">253</a>
<a href="#numpy.i-254">254</a>
<a href="#numpy.i-255">255</a>
<a href="#numpy.i-256">256</a>
<a href="#numpy.i-257">257</a>
<a href="#numpy.i-258">258</a>
<a href="#numpy.i-259">259</a>
<a href="#numpy.i-260">260</a>
<a href="#numpy.i-261">261</a>
<a href="#numpy.i-262">262</a>
<a href="#numpy.i-263">263</a>
<a href="#numpy.i-264">264</a>
<a href="#numpy.i-265">265</a>
<a href="#numpy.i-266">266</a>
<a href="#numpy.i-267">267</a>
<a href="#numpy.i-268">268</a>
<a href="#numpy.i-269">269</a>
<a href="#numpy.i-270">270</a>
<a href="#numpy.i-271">271</a>
<a href="#numpy.i-272">272</a>
<a href="#numpy.i-273">273</a>
<a href="#numpy.i-274">274</a>
<a href="#numpy.i-275">275</a>
<a href="#numpy.i-276">276</a>
<a href="#numpy.i-277">277</a>
<a href="#numpy.i-278">278</a>
<a href="#numpy.i-279">279</a>
<a href="#numpy.i-280">280</a>
<a href="#numpy.i-281">281</a>
<a href="#numpy.i-282">282</a>
<a href="#numpy.i-283">283</a>
<a href="#numpy.i-284">284</a>
<a href="#numpy.i-285">285</a>
<a href="#numpy.i-286">286</a>
<a href="#numpy.i-287">287</a>
<a href="#numpy.i-288">288</a>
<a href="#numpy.i-289">289</a>
<a href="#numpy.i-290">290</a>
<a href="#numpy.i-291">291</a>
<a href="#numpy.i-292">292</a>
<a href="#numpy.i-293">293</a>
<a href="#numpy.i-294">294</a>
<a href="#numpy.i-295">295</a>
<a href="#numpy.i-296">296</a>
<a href="#numpy.i-297">297</a>
<a href="#numpy.i-298">298</a>
<a href="#numpy.i-299">299</a>
<a href="#numpy.i-300">300</a>
<a href="#numpy.i-301">301</a>
<a href="#numpy.i-302">302</a>
<a href="#numpy.i-303">303</a>
<a href="#numpy.i-304">304</a>
<a href="#numpy.i-305">305</a>
<a href="#numpy.i-306">306</a>
<a href="#numpy.i-307">307</a>
<a href="#numpy.i-308">308</a>
<a href="#numpy.i-309">309</a>
<a href="#numpy.i-310">310</a>
<a href="#numpy.i-311">311</a>
<a href="#numpy.i-312">312</a>
<a href="#numpy.i-313">313</a>
<a href="#numpy.i-314">314</a>
<a href="#numpy.i-315">315</a>
<a href="#numpy.i-316">316</a>
<a href="#numpy.i-317">317</a>
<a href="#numpy.i-318">318</a>
<a href="#numpy.i-319">319</a>
<a href="#numpy.i-320">320</a>
<a href="#numpy.i-321">321</a>
<a href="#numpy.i-322">322</a>
<a href="#numpy.i-323">323</a>
<a href="#numpy.i-324">324</a>
<a href="#numpy.i-325">325</a>
<a href="#numpy.i-326">326</a>
<a href="#numpy.i-327">327</a>
<a href="#numpy.i-328">328</a>
<a href="#numpy.i-329">329</a>
<a href="#numpy.i-330">330</a>
<a href="#numpy.i-331">331</a>
<a href="#numpy.i-332">332</a>
<a href="#numpy.i-333">333</a>
<a href="#numpy.i-334">334</a>
<a href="#numpy.i-335">335</a>
<a href="#numpy.i-336">336</a>
<a href="#numpy.i-337">337</a>
<a href="#numpy.i-338">338</a>
<a href="#numpy.i-339">339</a>
<a href="#numpy.i-340">340</a>
<a href="#numpy.i-341">341</a>
<a href="#numpy.i-342">342</a>
<a href="#numpy.i-343">343</a>
<a href="#numpy.i-344">344</a>
<a href="#numpy.i-345">345</a>
<a href="#numpy.i-346">346</a>
<a href="#numpy.i-347">347</a>
<a href="#numpy.i-348">348</a>
<a href="#numpy.i-349">349</a>
<a href="#numpy.i-350">350</a>
<a href="#numpy.i-351">351</a>
<a href="#numpy.i-352">352</a>
<a href="#numpy.i-353">353</a>
<a href="#numpy.i-354">354</a>
<a href="#numpy.i-355">355</a>
<a href="#numpy.i-356">356</a>
<a href="#numpy.i-357">357</a>
<a href="#numpy.i-358">358</a>
<a href="#numpy.i-359">359</a>
<a href="#numpy.i-360">360</a>
<a href="#numpy.i-361">361</a>
<a href="#numpy.i-362">362</a>
<a href="#numpy.i-363">363</a>
<a href="#numpy.i-364">364</a>
<a href="#numpy.i-365">365</a>
<a href="#numpy.i-366">366</a>
<a href="#numpy.i-367">367</a>
<a href="#numpy.i-368">368</a>
<a href="#numpy.i-369">369</a>
<a href="#numpy.i-370">370</a>
<a href="#numpy.i-371">371</a>
<a href="#numpy.i-372">372</a>
<a href="#numpy.i-373">373</a>
<a href="#numpy.i-374">374</a>
<a href="#numpy.i-375">375</a>
<a href="#numpy.i-376">376</a>
<a href="#numpy.i-377">377</a>
<a href="#numpy.i-378">378</a>
<a href="#numpy.i-379">379</a>
<a href="#numpy.i-380">380</a>
<a href="#numpy.i-381">381</a>
<a href="#numpy.i-382">382</a>
<a href="#numpy.i-383">383</a>
<a href="#numpy.i-384">384</a>
<a href="#numpy.i-385">385</a>
<a href="#numpy.i-386">386</a>
<a href="#numpy.i-387">387</a>
<a href="#numpy.i-388">388</a>
<a href="#numpy.i-389">389</a>
<a href="#numpy.i-390">390</a>
<a href="#numpy.i-391">391</a>
<a href="#numpy.i-392">392</a>
<a href="#numpy.i-393">393</a>
<a href="#numpy.i-394">394</a>
<a href="#numpy.i-395">395</a>
<a href="#numpy.i-396">396</a>
<a href="#numpy.i-397">397</a>
<a href="#numpy.i-398">398</a>
<a href="#numpy.i-399">399</a>
<a href="#numpy.i-400">400</a>
<a href="#numpy.i-401">401</a>
<a href="#numpy.i-402">402</a>
<a href="#numpy.i-403">403</a>
<a href="#numpy.i-404">404</a>
<a href="#numpy.i-405">405</a>
<a href="#numpy.i-406">406</a>
<a href="#numpy.i-407">407</a>
<a href="#numpy.i-408">408</a>
<a href="#numpy.i-409">409</a>
<a href="#numpy.i-410">410</a>
<a href="#numpy.i-411">411</a>
<a href="#numpy.i-412">412</a>
<a href="#numpy.i-413">413</a>
<a href="#numpy.i-414">414</a>
<a href="#numpy.i-415">415</a>
<a href="#numpy.i-416">416</a>
<a href="#numpy.i-417">417</a>
<a href="#numpy.i-418">418</a>
<a href="#numpy.i-419">419</a>
<a href="#numpy.i-420">420</a>
<a href="#numpy.i-421">421</a>
<a href="#numpy.i-422">422</a>
<a href="#numpy.i-423">423</a>
<a href="#numpy.i-424">424</a>
<a href="#numpy.i-425">425</a>
<a href="#numpy.i-426">426</a>
<a href="#numpy.i-427">427</a>
<a href="#numpy.i-428">428</a>
<a href="#numpy.i-429">429</a>
<a href="#numpy.i-430">430</a>
<a href="#numpy.i-431">431</a>
<a href="#numpy.i-432">432</a>
<a href="#numpy.i-433">433</a>
<a href="#numpy.i-434">434</a>
<a href="#numpy.i-435">435</a>
<a href="#numpy.i-436">436</a>
<a href="#numpy.i-437">437</a>
<a href="#numpy.i-438">438</a>
<a href="#numpy.i-439">439</a>
<a href="#numpy.i-440">440</a>
<a href="#numpy.i-441">441</a>
<a href="#numpy.i-442">442</a>
<a href="#numpy.i-443">443</a>
<a href="#numpy.i-444">444</a>
<a href="#numpy.i-445">445</a>
<a href="#numpy.i-446">446</a>
<a href="#numpy.i-447">447</a>
<a href="#numpy.i-448">448</a>
<a href="#numpy.i-449">449</a>
<a href="#numpy.i-450">450</a>
<a href="#numpy.i-451">451</a>
<a href="#numpy.i-452">452</a>
<a href="#numpy.i-453">453</a>
<a href="#numpy.i-454">454</a>
<a href="#numpy.i-455">455</a>
<a href="#numpy.i-456">456</a>
<a href="#numpy.i-457">457</a>
<a href="#numpy.i-458">458</a>
<a href="#numpy.i-459">459</a>
<a href="#numpy.i-460">460</a>
<a href="#numpy.i-461">461</a>
<a href="#numpy.i-462">462</a>
<a href="#numpy.i-463">463</a>
<a href="#numpy.i-464">464</a>
<a href="#numpy.i-465">465</a>
<a href="#numpy.i-466">466</a>
<a href="#numpy.i-467">467</a>
<a href="#numpy.i-468">468</a>
<a href="#numpy.i-469">469</a>
<a href="#numpy.i-470">470</a>
<a href="#numpy.i-471">471</a>
<a href="#numpy.i-472">472</a>
<a href="#numpy.i-473">473</a>
<a href="#numpy.i-474">474</a>
<a href="#numpy.i-475">475</a>
<a href="#numpy.i-476">476</a>
<a href="#numpy.i-477">477</a>
<a href="#numpy.i-478">478</a>
<a href="#numpy.i-479">479</a>
<a href="#numpy.i-480">480</a>
<a href="#numpy.i-481">481</a>
<a href="#numpy.i-482">482</a>
<a href="#numpy.i-483">483</a>
<a href="#numpy.i-484">484</a>
<a href="#numpy.i-485">485</a>
<a href="#numpy.i-486">486</a>
<a href="#numpy.i-487">487</a>
<a href="#numpy.i-488">488</a>
<a href="#numpy.i-489">489</a>
<a href="#numpy.i-490">490</a>
<a href="#numpy.i-491">491</a>
<a href="#numpy.i-492">492</a>
<a href="#numpy.i-493">493</a>
<a href="#numpy.i-494">494</a>
<a href="#numpy.i-495">495</a>
<a href="#numpy.i-496">496</a>
<a href="#numpy.i-497">497</a>
<a href="#numpy.i-498">498</a>
<a href="#numpy.i-499">499</a>
<a href="#numpy.i-500">500</a>
<a href="#numpy.i-501">501</a>
<a href="#numpy.i-502">502</a>
<a href="#numpy.i-503">503</a>
<a href="#numpy.i-504">504</a>
<a href="#numpy.i-505">505</a>
<a href="#numpy.i-506">506</a>
<a href="#numpy.i-507">507</a>
<a href="#numpy.i-508">508</a>
<a href="#numpy.i-509">509</a>
<a href="#numpy.i-510">510</a>
<a href="#numpy.i-511">511</a>
<a href="#numpy.i-512">512</a>
<a href="#numpy.i-513">513</a>
<a href="#numpy.i-514">514</a>
<a href="#numpy.i-515">515</a>
<a href="#numpy.i-516">516</a>
<a href="#numpy.i-517">517</a>
<a href="#numpy.i-518">518</a>
<a href="#numpy.i-519">519</a>
<a href="#numpy.i-520">520</a>
<a href="#numpy.i-521">521</a>
<a href="#numpy.i-522">522</a>
<a href="#numpy.i-523">523</a>
<a href="#numpy.i-524">524</a>
<a href="#numpy.i-525">525</a>
<a href="#numpy.i-526">526</a>
<a href="#numpy.i-527">527</a>
<a href="#numpy.i-528">528</a>
<a href="#numpy.i-529">529</a>
<a href="#numpy.i-530">530</a>
<a href="#numpy.i-531">531</a>
<a href="#numpy.i-532">532</a>
<a href="#numpy.i-533">533</a>
<a href="#numpy.i-534">534</a>
<a href="#numpy.i-535">535</a>
<a href="#numpy.i-536">536</a>
<a href="#numpy.i-537">537</a>
<a href="#numpy.i-538">538</a>
<a href="#numpy.i-539">539</a>
<a href="#numpy.i-540">540</a>
<a href="#numpy.i-541">541</a>
<a href="#numpy.i-542">542</a>
<a href="#numpy.i-543">543</a>
<a href="#numpy.i-544">544</a>
<a href="#numpy.i-545">545</a>
<a href="#numpy.i-546">546</a>
<a href="#numpy.i-547">547</a>
<a href="#numpy.i-548">548</a>
<a href="#numpy.i-549">549</a>
<a href="#numpy.i-550">550</a>
<a href="#numpy.i-551">551</a>
<a href="#numpy.i-552">552</a>
<a href="#numpy.i-553">553</a>
<a href="#numpy.i-554">554</a>
<a href="#numpy.i-555">555</a>
<a href="#numpy.i-556">556</a>
<a href="#numpy.i-557">557</a>
<a href="#numpy.i-558">558</a>
<a href="#numpy.i-559">559</a>
<a href="#numpy.i-560">560</a>
<a href="#numpy.i-561">561</a>
<a href="#numpy.i-562">562</a>
<a href="#numpy.i-563">563</a>
<a href="#numpy.i-564">564</a>
<a href="#numpy.i-565">565</a>
<a href="#numpy.i-566">566</a>
<a href="#numpy.i-567">567</a>
<a href="#numpy.i-568">568</a>
<a href="#numpy.i-569">569</a>
<a href="#numpy.i-570">570</a>
<a href="#numpy.i-571">571</a>
<a href="#numpy.i-572">572</a>
<a href="#numpy.i-573">573</a>
<a href="#numpy.i-574">574</a>
<a href="#numpy.i-575">575</a>
<a href="#numpy.i-576">576</a>
<a href="#numpy.i-577">577</a>
<a href="#numpy.i-578">578</a>
<a href="#numpy.i-579">579</a>
<a href="#numpy.i-580">580</a>
<a href="#numpy.i-581">581</a>
<a href="#numpy.i-582">582</a>
<a href="#numpy.i-583">583</a>
<a href="#numpy.i-584">584</a>
<a href="#numpy.i-585">585</a>
<a href="#numpy.i-586">586</a>
<a href="#numpy.i-587">587</a>
<a href="#numpy.i-588">588</a>
<a href="#numpy.i-589">589</a>
<a href="#numpy.i-590">590</a>
<a href="#numpy.i-591">591</a>
<a href="#numpy.i-592">592</a>
<a href="#numpy.i-593">593</a>
<a href="#numpy.i-594">594</a>
<a href="#numpy.i-595">595</a>
<a href="#numpy.i-596">596</a>
<a href="#numpy.i-597">597</a>
<a href="#numpy.i-598">598</a>
<a href="#numpy.i-599">599</a>
<a href="#numpy.i-600">600</a>
<a href="#numpy.i-601">601</a>
<a href="#numpy.i-602">602</a>
<a href="#numpy.i-603">603</a>
<a href="#numpy.i-604">604</a>
<a href="#numpy.i-605">605</a>
<a href="#numpy.i-606">606</a>
<a href="#numpy.i-607">607</a>
<a href="#numpy.i-608">608</a>
<a href="#numpy.i-609">609</a>
<a href="#numpy.i-610">610</a>
<a href="#numpy.i-611">611</a>
<a href="#numpy.i-612">612</a>
<a href="#numpy.i-613">613</a>
<a href="#numpy.i-614">614</a>
<a href="#numpy.i-615">615</a>
<a href="#numpy.i-616">616</a>
<a href="#numpy.i-617">617</a>
<a href="#numpy.i-618">618</a>
<a href="#numpy.i-619">619</a>
<a href="#numpy.i-620">620</a>
<a href="#numpy.i-621">621</a>
<a href="#numpy.i-622">622</a>
<a href="#numpy.i-623">623</a>
<a href="#numpy.i-624">624</a>
<a href="#numpy.i-625">625</a>
<a href="#numpy.i-626">626</a>
<a href="#numpy.i-627">627</a>
<a href="#numpy.i-628">628</a>
<a href="#numpy.i-629">629</a>
<a href="#numpy.i-630">630</a>
<a href="#numpy.i-631">631</a>
<a href="#numpy.i-632">632</a>
<a href="#numpy.i-633">633</a>
<a href="#numpy.i-634">634</a>
<a href="#numpy.i-635">635</a>
<a href="#numpy.i-636">636</a>
<a href="#numpy.i-637">637</a>
<a href="#numpy.i-638">638</a>
<a href="#numpy.i-639">639</a>
<a href="#numpy.i-640">640</a>
<a href="#numpy.i-641">641</a>
<a href="#numpy.i-642">642</a>
<a href="#numpy.i-643">643</a>
<a href="#numpy.i-644">644</a>
<a href="#numpy.i-645">645</a>
<a href="#numpy.i-646">646</a>
<a href="#numpy.i-647">647</a>
<a href="#numpy.i-648">648</a>
<a href="#numpy.i-649">649</a>
<a href="#numpy.i-650">650</a>
<a href="#numpy.i-651">651</a>
<a href="#numpy.i-652">652</a>
<a href="#numpy.i-653">653</a>
<a href="#numpy.i-654">654</a>
<a href="#numpy.i-655">655</a>
<a href="#numpy.i-656">656</a>
<a href="#numpy.i-657">657</a>
<a href="#numpy.i-658">658</a>
<a href="#numpy.i-659">659</a>
<a href="#numpy.i-660">660</a>
<a href="#numpy.i-661">661</a>
<a href="#numpy.i-662">662</a>
<a href="#numpy.i-663">663</a>
<a href="#numpy.i-664">664</a>
<a href="#numpy.i-665">665</a>
<a href="#numpy.i-666">666</a>
<a href="#numpy.i-667">667</a>
<a href="#numpy.i-668">668</a>
<a href="#numpy.i-669">669</a>
<a href="#numpy.i-670">670</a>
<a href="#numpy.i-671">671</a>
<a href="#numpy.i-672">672</a>
<a href="#numpy.i-673">673</a>
<a href="#numpy.i-674">674</a>
<a href="#numpy.i-675">675</a>
<a href="#numpy.i-676">676</a>
<a href="#numpy.i-677">677</a>
<a href="#numpy.i-678">678</a>
<a href="#numpy.i-679">679</a>
<a href="#numpy.i-680">680</a>
<a href="#numpy.i-681">681</a>
<a href="#numpy.i-682">682</a>
<a href="#numpy.i-683">683</a>
<a href="#numpy.i-684">684</a>
<a href="#numpy.i-685">685</a>
<a href="#numpy.i-686">686</a>
<a href="#numpy.i-687">687</a>
<a href="#numpy.i-688">688</a>
<a href="#numpy.i-689">689</a>
<a href="#numpy.i-690">690</a>
<a href="#numpy.i-691">691</a>
<a href="#numpy.i-692">692</a>
<a href="#numpy.i-693">693</a>
<a href="#numpy.i-694">694</a>
<a href="#numpy.i-695">695</a>
<a href="#numpy.i-696">696</a>
<a href="#numpy.i-697">697</a>
<a href="#numpy.i-698">698</a>
<a href="#numpy.i-699">699</a>
<a href="#numpy.i-700">700</a>
<a href="#numpy.i-701">701</a>
<a href="#numpy.i-702">702</a>
<a href="#numpy.i-703">703</a>
<a href="#numpy.i-704">704</a>
<a href="#numpy.i-705">705</a>
<a href="#numpy.i-706">706</a>
<a href="#numpy.i-707">707</a>
<a href="#numpy.i-708">708</a>
<a href="#numpy.i-709">709</a>
<a href="#numpy.i-710">710</a>
<a href="#numpy.i-711">711</a>
<a href="#numpy.i-712">712</a>
<a href="#numpy.i-713">713</a>
<a href="#numpy.i-714">714</a>
<a href="#numpy.i-715">715</a>
<a href="#numpy.i-716">716</a>
<a href="#numpy.i-717">717</a>
<a href="#numpy.i-718">718</a>
<a href="#numpy.i-719">719</a>
<a href="#numpy.i-720">720</a>
<a href="#numpy.i-721">721</a>
<a href="#numpy.i-722">722</a>
<a href="#numpy.i-723">723</a>
<a href="#numpy.i-724">724</a>
<a href="#numpy.i-725">725</a>
<a href="#numpy.i-726">726</a>
<a href="#numpy.i-727">727</a>
<a href="#numpy.i-728">728</a>
<a href="#numpy.i-729">729</a>
<a href="#numpy.i-730">730</a>
<a href="#numpy.i-731">731</a>
<a href="#numpy.i-732">732</a>
<a href="#numpy.i-733">733</a>
<a href="#numpy.i-734">734</a>
<a href="#numpy.i-735">735</a>
<a href="#numpy.i-736">736</a>
<a href="#numpy.i-737">737</a>
<a href="#numpy.i-738">738</a>
<a href="#numpy.i-739">739</a>
<a href="#numpy.i-740">740</a>
<a href="#numpy.i-741">741</a>
<a href="#numpy.i-742">742</a>
<a href="#numpy.i-743">743</a>
<a href="#numpy.i-744">744</a>
<a href="#numpy.i-745">745</a>
<a href="#numpy.i-746">746</a>
<a href="#numpy.i-747">747</a>
<a href="#numpy.i-748">748</a>
<a href="#numpy.i-749">749</a>
<a href="#numpy.i-750">750</a>
<a href="#numpy.i-751">751</a>
<a href="#numpy.i-752">752</a>
<a href="#numpy.i-753">753</a>
<a href="#numpy.i-754">754</a>
<a href="#numpy.i-755">755</a>
<a href="#numpy.i-756">756</a>
<a href="#numpy.i-757">757</a>
<a href="#numpy.i-758">758</a>
<a href="#numpy.i-759">759</a>
<a href="#numpy.i-760">760</a>
<a href="#numpy.i-761">761</a>
<a href="#numpy.i-762">762</a>
<a href="#numpy.i-763">763</a>
<a href="#numpy.i-764">764</a>
<a href="#numpy.i-765">765</a>
<a href="#numpy.i-766">766</a>
<a href="#numpy.i-767">767</a>
<a href="#numpy.i-768">768</a>
<a href="#numpy.i-769">769</a>
<a href="#numpy.i-770">770</a>
<a href="#numpy.i-771">771</a>
<a href="#numpy.i-772">772</a>
<a href="#numpy.i-773">773</a>
<a href="#numpy.i-774">774</a>
<a href="#numpy.i-775">775</a>
<a href="#numpy.i-776">776</a>
<a href="#numpy.i-777">777</a>
<a href="#numpy.i-778">778</a>
<a href="#numpy.i-779">779</a>
<a href="#numpy.i-780">780</a>
<a href="#numpy.i-781">781</a>
<a href="#numpy.i-782">782</a>
<a href="#numpy.i-783">783</a>
<a href="#numpy.i-784">784</a>
<a href="#numpy.i-785">785</a>
<a href="#numpy.i-786">786</a>
<a href="#numpy.i-787">787</a>
<a href="#numpy.i-788">788</a>
<a href="#numpy.i-789">789</a>
<a href="#numpy.i-790">790</a>
<a href="#numpy.i-791">791</a>
<a href="#numpy.i-792">792</a>
<a href="#numpy.i-793">793</a>
<a href="#numpy.i-794">794</a>
<a href="#numpy.i-795">795</a>
<a href="#numpy.i-796">796</a>
<a href="#numpy.i-797">797</a>
<a href="#numpy.i-798">798</a>
<a href="#numpy.i-799">799</a>
<a href="#numpy.i-800">800</a>
<a href="#numpy.i-801">801</a>
<a href="#numpy.i-802">802</a>
<a href="#numpy.i-803">803</a>
<a href="#numpy.i-804">804</a>
<a href="#numpy.i-805">805</a>
<a href="#numpy.i-806">806</a>
<a href="#numpy.i-807">807</a>
<a href="#numpy.i-808">808</a>
<a href="#numpy.i-809">809</a>
<a href="#numpy.i-810">810</a>
<a href="#numpy.i-811">811</a>
<a href="#numpy.i-812">812</a>
<a href="#numpy.i-813">813</a>
<a href="#numpy.i-814">814</a>
<a href="#numpy.i-815">815</a>
<a href="#numpy.i-816">816</a>
<a href="#numpy.i-817">817</a>
<a href="#numpy.i-818">818</a>
<a href="#numpy.i-819">819</a>
<a href="#numpy.i-820">820</a>
<a href="#numpy.i-821">821</a>
<a href="#numpy.i-822">822</a>
<a href="#numpy.i-823">823</a>
<a href="#numpy.i-824">824</a>
<a href="#numpy.i-825">825</a>
<a href="#numpy.i-826">826</a>
<a href="#numpy.i-827">827</a>
<a href="#numpy.i-828">828</a>
<a href="#numpy.i-829">829</a>
<a href="#numpy.i-830">830</a>
<a href="#numpy.i-831">831</a>
<a href="#numpy.i-832">832</a>
<a href="#numpy.i-833">833</a>
<a href="#numpy.i-834">834</a>
<a href="#numpy.i-835">835</a>
<a href="#numpy.i-836">836</a>
<a href="#numpy.i-837">837</a>
<a href="#numpy.i-838">838</a>
<a href="#numpy.i-839">839</a>
<a href="#numpy.i-840">840</a>
<a href="#numpy.i-841">841</a>
<a href="#numpy.i-842">842</a>
<a href="#numpy.i-843">843</a>
<a href="#numpy.i-844">844</a>
<a href="#numpy.i-845">845</a>
<a href="#numpy.i-846">846</a>
<a href="#numpy.i-847">847</a>
<a href="#numpy.i-848">848</a>
<a href="#numpy.i-849">849</a>
<a href="#numpy.i-850">850</a>
<a href="#numpy.i-851">851</a>
<a href="#numpy.i-852">852</a>
<a href="#numpy.i-853">853</a>
<a href="#numpy.i-854">854</a>
<a href="#numpy.i-855">855</a>
<a href="#numpy.i-856">856</a>
<a href="#numpy.i-857">857</a>
<a href="#numpy.i-858">858</a>
<a href="#numpy.i-859">859</a>
<a href="#numpy.i-860">860</a>
<a href="#numpy.i-861">861</a>
<a href="#numpy.i-862">862</a>
<a href="#numpy.i-863">863</a>
<a href="#numpy.i-864">864</a>
<a href="#numpy.i-865">865</a>
<a href="#numpy.i-866">866</a>
<a href="#numpy.i-867">867</a>
<a href="#numpy.i-868">868</a>
<a href="#numpy.i-869">869</a>
<a href="#numpy.i-870">870</a>
<a href="#numpy.i-871">871</a>
<a href="#numpy.i-872">872</a>
<a href="#numpy.i-873">873</a>
<a href="#numpy.i-874">874</a>
<a href="#numpy.i-875">875</a>
<a href="#numpy.i-876">876</a>
<a href="#numpy.i-877">877</a>
<a href="#numpy.i-878">878</a>
<a href="#numpy.i-879">879</a>
<a href="#numpy.i-880">880</a>
<a href="#numpy.i-881">881</a>
<a href="#numpy.i-882">882</a>
<a href="#numpy.i-883">883</a>
<a href="#numpy.i-884">884</a>
<a href="#numpy.i-885">885</a>
<a href="#numpy.i-886">886</a>
<a href="#numpy.i-887">887</a>
<a href="#numpy.i-888">888</a>
<a href="#numpy.i-889">889</a>
<a href="#numpy.i-890">890</a>
<a href="#numpy.i-891">891</a>
<a href="#numpy.i-892">892</a>
<a href="#numpy.i-893">893</a>
<a href="#numpy.i-894">894</a>
<a href="#numpy.i-895">895</a>
<a href="#numpy.i-896">896</a>
<a href="#numpy.i-897">897</a>
<a href="#numpy.i-898">898</a>
<a href="#numpy.i-899">899</a>
<a href="#numpy.i-900">900</a>
<a href="#numpy.i-901">901</a>
<a href="#numpy.i-902">902</a>
<a href="#numpy.i-903">903</a>
<a href="#numpy.i-904">904</a>
<a href="#numpy.i-905">905</a>
<a href="#numpy.i-906">906</a>
<a href="#numpy.i-907">907</a>
<a href="#numpy.i-908">908</a>
<a href="#numpy.i-909">909</a>
<a href="#numpy.i-910">910</a>
<a href="#numpy.i-911">911</a>
<a href="#numpy.i-912">912</a>
<a href="#numpy.i-913">913</a>
<a href="#numpy.i-914">914</a>
<a href="#numpy.i-915">915</a>
<a href="#numpy.i-916">916</a>
<a href="#numpy.i-917">917</a>
<a href="#numpy.i-918">918</a>
<a href="#numpy.i-919">919</a>
<a href="#numpy.i-920">920</a>
<a href="#numpy.i-921">921</a>
<a href="#numpy.i-922">922</a>
<a href="#numpy.i-923">923</a>
<a href="#numpy.i-924">924</a>
<a href="#numpy.i-925">925</a>
<a href="#numpy.i-926">926</a>
<a href="#numpy.i-927">927</a>
<a href="#numpy.i-928">928</a>
<a href="#numpy.i-929">929</a>
<a href="#numpy.i-930">930</a>
<a href="#numpy.i-931">931</a>
<a href="#numpy.i-932">932</a>
<a href="#numpy.i-933">933</a>
<a href="#numpy.i-934">934</a>
<a href="#numpy.i-935">935</a>
<a href="#numpy.i-936">936</a>
<a href="#numpy.i-937">937</a>
<a href="#numpy.i-938">938</a>
<a href="#numpy.i-939">939</a>
<a href="#numpy.i-940">940</a>
<a href="#numpy.i-941">941</a>
<a href="#numpy.i-942">942</a>
<a href="#numpy.i-943">943</a>
<a href="#numpy.i-944">944</a>
<a href="#numpy.i-945">945</a>
<a href="#numpy.i-946">946</a>
<a href="#numpy.i-947">947</a>
<a href="#numpy.i-948">948</a>
<a href="#numpy.i-949">949</a>
<a href="#numpy.i-950">950</a>
<a href="#numpy.i-951">951</a>
<a href="#numpy.i-952">952</a>
<a href="#numpy.i-953">953</a>
<a href="#numpy.i-954">954</a>
<a href="#numpy.i-955">955</a>
<a href="#numpy.i-956">956</a>
<a href="#numpy.i-957">957</a>
<a href="#numpy.i-958">958</a>
<a href="#numpy.i-959">959</a>
<a href="#numpy.i-960">960</a>
<a href="#numpy.i-961">961</a>
<a href="#numpy.i-962">962</a>
<a href="#numpy.i-963">963</a>
<a href="#numpy.i-964">964</a>
<a href="#numpy.i-965">965</a>
<a href="#numpy.i-966">966</a>
<a href="#numpy.i-967">967</a>
<a href="#numpy.i-968">968</a>
<a href="#numpy.i-969">969</a>
<a href="#numpy.i-970">970</a>
<a href="#numpy.i-971">971</a>
<a href="#numpy.i-972">972</a>
<a href="#numpy.i-973">973</a>
<a href="#numpy.i-974">974</a>
<a href="#numpy.i-975">975</a>
<a href="#numpy.i-976">976</a>
<a href="#numpy.i-977">977</a>
<a href="#numpy.i-978">978</a>
<a href="#numpy.i-979">979</a>
<a href="#numpy.i-980">980</a>
<a href="#numpy.i-981">981</a>
<a href="#numpy.i-982">982</a>
<a href="#numpy.i-983">983</a>
<a href="#numpy.i-984">984</a>
<a href="#numpy.i-985">985</a>
<a href="#numpy.i-986">986</a>
<a href="#numpy.i-987">987</a>
<a href="#numpy.i-988">988</a>
<a href="#numpy.i-989">989</a>
<a href="#numpy.i-990">990</a>
<a href="#numpy.i-991">991</a>
<a href="#numpy.i-992">992</a>
<a href="#numpy.i-993">993</a>
<a href="#numpy.i-994">994</a>
<a href="#numpy.i-995">995</a>
<a href="#numpy.i-996">996</a>
<a href="#numpy.i-997">997</a>
<a href="#numpy.i-998">998</a>
<a href="#numpy.i-999">999</a>
<a href="#numpy.i-1000">1000</a>
<a href="#numpy.i-1001">1001</a>
<a href="#numpy.i-1002">1002</a>
<a href="#numpy.i-1003">1003</a>
<a href="#numpy.i-1004">1004</a>
<a href="#numpy.i-1005">1005</a>
<a href="#numpy.i-1006">1006</a>
<a href="#numpy.i-1007">1007</a>
<a href="#numpy.i-1008">1008</a>
<a href="#numpy.i-1009">1009</a>
<a href="#numpy.i-1010">1010</a>
<a href="#numpy.i-1011">1011</a>
<a href="#numpy.i-1012">1012</a>
<a href="#numpy.i-1013">1013</a>
<a href="#numpy.i-1014">1014</a>
<a href="#numpy.i-1015">1015</a>
<a href="#numpy.i-1016">1016</a>
<a href="#numpy.i-1017">1017</a>
<a href="#numpy.i-1018">1018</a>
<a href="#numpy.i-1019">1019</a>
<a href="#numpy.i-1020">1020</a>
<a href="#numpy.i-1021">1021</a>
<a href="#numpy.i-1022">1022</a>
<a href="#numpy.i-1023">1023</a>
<a href="#numpy.i-1024">1024</a>
<a href="#numpy.i-1025">1025</a>
<a href="#numpy.i-1026">1026</a>
<a href="#numpy.i-1027">1027</a>
<a href="#numpy.i-1028">1028</a>
<a href="#numpy.i-1029">1029</a>
<a href="#numpy.i-1030">1030</a>
<a href="#numpy.i-1031">1031</a>
<a href="#numpy.i-1032">1032</a>
<a href="#numpy.i-1033">1033</a>
<a href="#numpy.i-1034">1034</a>
<a href="#numpy.i-1035">1035</a>
<a href="#numpy.i-1036">1036</a>
<a href="#numpy.i-1037">1037</a>
<a href="#numpy.i-1038">1038</a>
<a href="#numpy.i-1039">1039</a>
<a href="#numpy.i-1040">1040</a>
<a href="#numpy.i-1041">1041</a>
<a href="#numpy.i-1042">1042</a>
<a href="#numpy.i-1043">1043</a>
<a href="#numpy.i-1044">1044</a>
<a href="#numpy.i-1045">1045</a>
<a href="#numpy.i-1046">1046</a>
<a href="#numpy.i-1047">1047</a>
<a href="#numpy.i-1048">1048</a>
<a href="#numpy.i-1049">1049</a>
<a href="#numpy.i-1050">1050</a>
<a href="#numpy.i-1051">1051</a>
<a href="#numpy.i-1052">1052</a>
<a href="#numpy.i-1053">1053</a>
<a href="#numpy.i-1054">1054</a>
<a href="#numpy.i-1055">1055</a>
<a href="#numpy.i-1056">1056</a>
<a href="#numpy.i-1057">1057</a>
<a href="#numpy.i-1058">1058</a>
<a href="#numpy.i-1059">1059</a>
<a href="#numpy.i-1060">1060</a>
<a href="#numpy.i-1061">1061</a>
<a href="#numpy.i-1062">1062</a>
<a href="#numpy.i-1063">1063</a>
<a href="#numpy.i-1064">1064</a>
<a href="#numpy.i-1065">1065</a>
<a href="#numpy.i-1066">1066</a>
<a href="#numpy.i-1067">1067</a>
<a href="#numpy.i-1068">1068</a>
<a href="#numpy.i-1069">1069</a>
<a href="#numpy.i-1070">1070</a>
<a href="#numpy.i-1071">1071</a>
<a href="#numpy.i-1072">1072</a>
<a href="#numpy.i-1073">1073</a>
<a href="#numpy.i-1074">1074</a>
<a href="#numpy.i-1075">1075</a>
<a href="#numpy.i-1076">1076</a>
<a href="#numpy.i-1077">1077</a>
<a href="#numpy.i-1078">1078</a>
<a href="#numpy.i-1079">1079</a>
<a href="#numpy.i-1080">1080</a>
<a href="#numpy.i-1081">1081</a>
<a href="#numpy.i-1082">1082</a>
<a href="#numpy.i-1083">1083</a>
<a href="#numpy.i-1084">1084</a>
<a href="#numpy.i-1085">1085</a>
<a href="#numpy.i-1086">1086</a>
<a href="#numpy.i-1087">1087</a>
<a href="#numpy.i-1088">1088</a>
<a href="#numpy.i-1089">1089</a>
<a href="#numpy.i-1090">1090</a>
<a href="#numpy.i-1091">1091</a>
<a href="#numpy.i-1092">1092</a>
<a href="#numpy.i-1093">1093</a>
<a href="#numpy.i-1094">1094</a>
<a href="#numpy.i-1095">1095</a>
<a href="#numpy.i-1096">1096</a>
<a href="#numpy.i-1097">1097</a>
<a href="#numpy.i-1098">1098</a>
<a href="#numpy.i-1099">1099</a>
<a href="#numpy.i-1100">1100</a>
<a href="#numpy.i-1101">1101</a>
<a href="#numpy.i-1102">1102</a>
<a href="#numpy.i-1103">1103</a>
<a href="#numpy.i-1104">1104</a>
<a href="#numpy.i-1105">1105</a>
<a href="#numpy.i-1106">1106</a>
<a href="#numpy.i-1107">1107</a>
<a href="#numpy.i-1108">1108</a>
<a href="#numpy.i-1109">1109</a>
<a href="#numpy.i-1110">1110</a>
<a href="#numpy.i-1111">1111</a>
<a href="#numpy.i-1112">1112</a>
<a href="#numpy.i-1113">1113</a>
<a href="#numpy.i-1114">1114</a>
<a href="#numpy.i-1115">1115</a>
<a href="#numpy.i-1116">1116</a>
<a href="#numpy.i-1117">1117</a>
<a href="#numpy.i-1118">1118</a>
<a href="#numpy.i-1119">1119</a>
<a href="#numpy.i-1120">1120</a>
<a href="#numpy.i-1121">1121</a>
<a href="#numpy.i-1122">1122</a>
<a href="#numpy.i-1123">1123</a>
<a href="#numpy.i-1124">1124</a>
<a href="#numpy.i-1125">1125</a>
<a href="#numpy.i-1126">1126</a>
<a href="#numpy.i-1127">1127</a>
<a href="#numpy.i-1128">1128</a>
<a href="#numpy.i-1129">1129</a>
<a href="#numpy.i-1130">1130</a>
<a href="#numpy.i-1131">1131</a>
<a href="#numpy.i-1132">1132</a>
<a href="#numpy.i-1133">1133</a>
<a href="#numpy.i-1134">1134</a>
<a href="#numpy.i-1135">1135</a>
<a href="#numpy.i-1136">1136</a>
<a href="#numpy.i-1137">1137</a>
<a href="#numpy.i-1138">1138</a>
<a href="#numpy.i-1139">1139</a>
<a href="#numpy.i-1140">1140</a>
<a href="#numpy.i-1141">1141</a>
<a href="#numpy.i-1142">1142</a>
<a href="#numpy.i-1143">1143</a>
<a href="#numpy.i-1144">1144</a>
<a href="#numpy.i-1145">1145</a>
<a href="#numpy.i-1146">1146</a>
<a href="#numpy.i-1147">1147</a>
<a href="#numpy.i-1148">1148</a>
<a href="#numpy.i-1149">1149</a>
<a href="#numpy.i-1150">1150</a>
<a href="#numpy.i-1151">1151</a>
<a href="#numpy.i-1152">1152</a>
<a href="#numpy.i-1153">1153</a>
<a href="#numpy.i-1154">1154</a>
<a href="#numpy.i-1155">1155</a>
<a href="#numpy.i-1156">1156</a>
<a href="#numpy.i-1157">1157</a>
<a href="#numpy.i-1158">1158</a>
<a href="#numpy.i-1159">1159</a>
<a href="#numpy.i-1160">1160</a>
<a href="#numpy.i-1161">1161</a>
<a href="#numpy.i-1162">1162</a>
<a href="#numpy.i-1163">1163</a>
<a href="#numpy.i-1164">1164</a>
<a href="#numpy.i-1165">1165</a>
<a href="#numpy.i-1166">1166</a>
<a href="#numpy.i-1167">1167</a>
<a href="#numpy.i-1168">1168</a>
<a href="#numpy.i-1169">1169</a>
<a href="#numpy.i-1170">1170</a>
<a href="#numpy.i-1171">1171</a>
<a href="#numpy.i-1172">1172</a>
<a href="#numpy.i-1173">1173</a>
<a href="#numpy.i-1174">1174</a>
<a href="#numpy.i-1175">1175</a>
<a href="#numpy.i-1176">1176</a>
<a href="#numpy.i-1177">1177</a>
<a href="#numpy.i-1178">1178</a>
<a href="#numpy.i-1179">1179</a>
<a href="#numpy.i-1180">1180</a>
<a href="#numpy.i-1181">1181</a>
<a href="#numpy.i-1182">1182</a>
<a href="#numpy.i-1183">1183</a>
<a href="#numpy.i-1184">1184</a>
<a href="#numpy.i-1185">1185</a>
<a href="#numpy.i-1186">1186</a>
<a href="#numpy.i-1187">1187</a>
<a href="#numpy.i-1188">1188</a>
<a href="#numpy.i-1189">1189</a>
<a href="#numpy.i-1190">1190</a>
<a href="#numpy.i-1191">1191</a>
<a href="#numpy.i-1192">1192</a>
<a href="#numpy.i-1193">1193</a>
<a href="#numpy.i-1194">1194</a>
<a href="#numpy.i-1195">1195</a>
<a href="#numpy.i-1196">1196</a>
<a href="#numpy.i-1197">1197</a>
<a href="#numpy.i-1198">1198</a>
<a href="#numpy.i-1199">1199</a>
<a href="#numpy.i-1200">1200</a>
<a href="#numpy.i-1201">1201</a>
<a href="#numpy.i-1202">1202</a>
<a href="#numpy.i-1203">1203</a>
<a href="#numpy.i-1204">1204</a>
<a href="#numpy.i-1205">1205</a>
<a href="#numpy.i-1206">1206</a>
<a href="#numpy.i-1207">1207</a>
<a href="#numpy.i-1208">1208</a>
<a href="#numpy.i-1209">1209</a>
<a href="#numpy.i-1210">1210</a>
<a href="#numpy.i-1211">1211</a>
<a href="#numpy.i-1212">1212</a>
<a href="#numpy.i-1213">1213</a>
<a href="#numpy.i-1214">1214</a>
<a href="#numpy.i-1215">1215</a>
<a href="#numpy.i-1216">1216</a>
<a href="#numpy.i-1217">1217</a>
<a href="#numpy.i-1218">1218</a>
<a href="#numpy.i-1219">1219</a>
<a href="#numpy.i-1220">1220</a>
<a href="#numpy.i-1221">1221</a>
<a href="#numpy.i-1222">1222</a>
<a href="#numpy.i-1223">1223</a>
<a href="#numpy.i-1224">1224</a>
<a href="#numpy.i-1225">1225</a>
<a href="#numpy.i-1226">1226</a>
<a href="#numpy.i-1227">1227</a>
<a href="#numpy.i-1228">1228</a>
<a href="#numpy.i-1229">1229</a>
<a href="#numpy.i-1230">1230</a>
<a href="#numpy.i-1231">1231</a>
<a href="#numpy.i-1232">1232</a>
<a href="#numpy.i-1233">1233</a>
<a href="#numpy.i-1234">1234</a>
<a href="#numpy.i-1235">1235</a>
<a href="#numpy.i-1236">1236</a>
<a href="#numpy.i-1237">1237</a>
<a href="#numpy.i-1238">1238</a>
<a href="#numpy.i-1239">1239</a>
<a href="#numpy.i-1240">1240</a>
<a href="#numpy.i-1241">1241</a>
<a href="#numpy.i-1242">1242</a>
<a href="#numpy.i-1243">1243</a>
<a href="#numpy.i-1244">1244</a>
<a href="#numpy.i-1245">1245</a>
<a href="#numpy.i-1246">1246</a>
<a href="#numpy.i-1247">1247</a>
<a href="#numpy.i-1248">1248</a>
<a href="#numpy.i-1249">1249</a>
<a href="#numpy.i-1250">1250</a>
<a href="#numpy.i-1251">1251</a>
<a href="#numpy.i-1252">1252</a>
<a href="#numpy.i-1253">1253</a>
<a href="#numpy.i-1254">1254</a>
<a href="#numpy.i-1255">1255</a>
<a href="#numpy.i-1256">1256</a>
<a href="#numpy.i-1257">1257</a>
<a href="#numpy.i-1258">1258</a>
<a href="#numpy.i-1259">1259</a>
<a href="#numpy.i-1260">1260</a>
<a href="#numpy.i-1261">1261</a>
<a href="#numpy.i-1262">1262</a>
<a href="#numpy.i-1263">1263</a>
<a href="#numpy.i-1264">1264</a>
<a href="#numpy.i-1265">1265</a>
<a href="#numpy.i-1266">1266</a>
<a href="#numpy.i-1267">1267</a>
<a href="#numpy.i-1268">1268</a>
<a href="#numpy.i-1269">1269</a>
<a href="#numpy.i-1270">1270</a>
<a href="#numpy.i-1271">1271</a>
<a href="#numpy.i-1272">1272</a>
<a href="#numpy.i-1273">1273</a>
<a href="#numpy.i-1274">1274</a>
<a href="#numpy.i-1275">1275</a>
<a href="#numpy.i-1276">1276</a>
<a href="#numpy.i-1277">1277</a>
<a href="#numpy.i-1278">1278</a>
<a href="#numpy.i-1279">1279</a>
<a href="#numpy.i-1280">1280</a>
<a href="#numpy.i-1281">1281</a>
<a href="#numpy.i-1282">1282</a>
<a href="#numpy.i-1283">1283</a>
<a href="#numpy.i-1284">1284</a>
<a href="#numpy.i-1285">1285</a>
<a href="#numpy.i-1286">1286</a>
<a href="#numpy.i-1287">1287</a>
<a href="#numpy.i-1288">1288</a>
<a href="#numpy.i-1289">1289</a>
<a href="#numpy.i-1290">1290</a>
<a href="#numpy.i-1291">1291</a>
<a href="#numpy.i-1292">1292</a>
<a href="#numpy.i-1293">1293</a>
<a href="#numpy.i-1294">1294</a>
<a href="#numpy.i-1295">1295</a>
<a href="#numpy.i-1296">1296</a>
<a href="#numpy.i-1297">1297</a>
<a href="#numpy.i-1298">1298</a>
<a href="#numpy.i-1299">1299</a>
<a href="#numpy.i-1300">1300</a>
<a href="#numpy.i-1301">1301</a>
<a href="#numpy.i-1302">1302</a>
<a href="#numpy.i-1303">1303</a>
<a href="#numpy.i-1304">1304</a>
<a href="#numpy.i-1305">1305</a>
<a href="#numpy.i-1306">1306</a>
<a href="#numpy.i-1307">1307</a>
<a href="#numpy.i-1308">1308</a>
<a href="#numpy.i-1309">1309</a>
<a href="#numpy.i-1310">1310</a>
<a href="#numpy.i-1311">1311</a>
<a href="#numpy.i-1312">1312</a>
<a href="#numpy.i-1313">1313</a>
<a href="#numpy.i-1314">1314</a>
<a href="#numpy.i-1315">1315</a>
<a href="#numpy.i-1316">1316</a>
<a href="#numpy.i-1317">1317</a>
<a href="#numpy.i-1318">1318</a>
<a href="#numpy.i-1319">1319</a>
<a href="#numpy.i-1320">1320</a>
<a href="#numpy.i-1321">1321</a>
<a href="#numpy.i-1322">1322</a>
<a href="#numpy.i-1323">1323</a>
<a href="#numpy.i-1324">1324</a>
<a href="#numpy.i-1325">1325</a>
<a href="#numpy.i-1326">1326</a>
<a href="#numpy.i-1327">1327</a>
<a href="#numpy.i-1328">1328</a>
<a href="#numpy.i-1329">1329</a>
<a href="#numpy.i-1330">1330</a>
<a href="#numpy.i-1331">1331</a>
<a href="#numpy.i-1332">1332</a>
<a href="#numpy.i-1333">1333</a>
<a href="#numpy.i-1334">1334</a>
<a href="#numpy.i-1335">1335</a>
<a href="#numpy.i-1336">1336</a>
<a href="#numpy.i-1337">1337</a>
<a href="#numpy.i-1338">1338</a>
<a href="#numpy.i-1339">1339</a>
<a href="#numpy.i-1340">1340</a>
<a href="#numpy.i-1341">1341</a>
<a href="#numpy.i-1342">1342</a>
<a href="#numpy.i-1343">1343</a>
<a href="#numpy.i-1344">1344</a>
<a href="#numpy.i-1345">1345</a>
<a href="#numpy.i-1346">1346</a>
<a href="#numpy.i-1347">1347</a>
<a href="#numpy.i-1348">1348</a>
<a href="#numpy.i-1349">1349</a>
<a href="#numpy.i-1350">1350</a>
<a href="#numpy.i-1351">1351</a>
<a href="#numpy.i-1352">1352</a>
<a href="#numpy.i-1353">1353</a>
<a href="#numpy.i-1354">1354</a>
<a href="#numpy.i-1355">1355</a>
<a href="#numpy.i-1356">1356</a>
<a href="#numpy.i-1357">1357</a>
<a href="#numpy.i-1358">1358</a>
<a href="#numpy.i-1359">1359</a>
<a href="#numpy.i-1360">1360</a>
<a href="#numpy.i-1361">1361</a>
<a href="#numpy.i-1362">1362</a>
<a href="#numpy.i-1363">1363</a>
<a href="#numpy.i-1364">1364</a>
<a href="#numpy.i-1365">1365</a>
<a href="#numpy.i-1366">1366</a>
<a href="#numpy.i-1367">1367</a>
<a href="#numpy.i-1368">1368</a>
<a href="#numpy.i-1369">1369</a>
<a href="#numpy.i-1370">1370</a>
<a href="#numpy.i-1371">1371</a>
<a href="#numpy.i-1372">1372</a>
<a href="#numpy.i-1373">1373</a>
<a href="#numpy.i-1374">1374</a>
<a href="#numpy.i-1375">1375</a>
<a href="#numpy.i-1376">1376</a>
<a href="#numpy.i-1377">1377</a>
<a href="#numpy.i-1378">1378</a>
<a href="#numpy.i-1379">1379</a>
<a href="#numpy.i-1380">1380</a>
<a href="#numpy.i-1381">1381</a>
<a href="#numpy.i-1382">1382</a>
<a href="#numpy.i-1383">1383</a>
<a href="#numpy.i-1384">1384</a>
<a href="#numpy.i-1385">1385</a>
<a href="#numpy.i-1386">1386</a>
<a href="#numpy.i-1387">1387</a>
<a href="#numpy.i-1388">1388</a>
<a href="#numpy.i-1389">1389</a>
<a href="#numpy.i-1390">1390</a>
<a href="#numpy.i-1391">1391</a>
<a href="#numpy.i-1392">1392</a>
<a href="#numpy.i-1393">1393</a>
<a href="#numpy.i-1394">1394</a>
<a href="#numpy.i-1395">1395</a>
<a href="#numpy.i-1396">1396</a>
<a href="#numpy.i-1397">1397</a>
<a href="#numpy.i-1398">1398</a>
<a href="#numpy.i-1399">1399</a>
<a href="#numpy.i-1400">1400</a>
<a href="#numpy.i-1401">1401</a>
<a href="#numpy.i-1402">1402</a>
<a href="#numpy.i-1403">1403</a>
<a href="#numpy.i-1404">1404</a>
<a href="#numpy.i-1405">1405</a>
<a href="#numpy.i-1406">1406</a>
<a href="#numpy.i-1407">1407</a>
<a href="#numpy.i-1408">1408</a>
<a href="#numpy.i-1409">1409</a>
<a href="#numpy.i-1410">1410</a>
<a href="#numpy.i-1411">1411</a>
<a href="#numpy.i-1412">1412</a>
<a href="#numpy.i-1413">1413</a>
<a href="#numpy.i-1414">1414</a>
<a href="#numpy.i-1415">1415</a>
<a href="#numpy.i-1416">1416</a>
<a href="#numpy.i-1417">1417</a>
<a href="#numpy.i-1418">1418</a>
<a href="#numpy.i-1419">1419</a>
<a href="#numpy.i-1420">1420</a>
<a href="#numpy.i-1421">1421</a>
<a href="#numpy.i-1422">1422</a>
<a href="#numpy.i-1423">1423</a>
<a href="#numpy.i-1424">1424</a>
<a href="#numpy.i-1425">1425</a>
<a href="#numpy.i-1426">1426</a>
<a href="#numpy.i-1427">1427</a>
<a href="#numpy.i-1428">1428</a>
<a href="#numpy.i-1429">1429</a>
<a href="#numpy.i-1430">1430</a>
<a href="#numpy.i-1431">1431</a>
<a href="#numpy.i-1432">1432</a>
<a href="#numpy.i-1433">1433</a>
<a href="#numpy.i-1434">1434</a>
<a href="#numpy.i-1435">1435</a>
<a href="#numpy.i-1436">1436</a>
<a href="#numpy.i-1437">1437</a>
<a href="#numpy.i-1438">1438</a>
<a href="#numpy.i-1439">1439</a>
<a href="#numpy.i-1440">1440</a>
<a href="#numpy.i-1441">1441</a>
<a href="#numpy.i-1442">1442</a>
<a href="#numpy.i-1443">1443</a>
<a href="#numpy.i-1444">1444</a>
<a href="#numpy.i-1445">1445</a>
<a href="#numpy.i-1446">1446</a>
<a href="#numpy.i-1447">1447</a>
<a href="#numpy.i-1448">1448</a>
<a href="#numpy.i-1449">1449</a>
<a href="#numpy.i-1450">1450</a>
<a href="#numpy.i-1451">1451</a>
<a href="#numpy.i-1452">1452</a>
<a href="#numpy.i-1453">1453</a>
<a href="#numpy.i-1454">1454</a>
<a href="#numpy.i-1455">1455</a>
<a href="#numpy.i-1456">1456</a>
<a href="#numpy.i-1457">1457</a>
<a href="#numpy.i-1458">1458</a>
<a href="#numpy.i-1459">1459</a>
<a href="#numpy.i-1460">1460</a>
<a href="#numpy.i-1461">1461</a>
<a href="#numpy.i-1462">1462</a>
<a href="#numpy.i-1463">1463</a>
<a href="#numpy.i-1464">1464</a>
<a href="#numpy.i-1465">1465</a>
<a href="#numpy.i-1466">1466</a>
<a href="#numpy.i-1467">1467</a>
<a href="#numpy.i-1468">1468</a>
<a href="#numpy.i-1469">1469</a>
<a href="#numpy.i-1470">1470</a>
<a href="#numpy.i-1471">1471</a>
<a href="#numpy.i-1472">1472</a>
<a href="#numpy.i-1473">1473</a>
<a href="#numpy.i-1474">1474</a>
<a href="#numpy.i-1475">1475</a>
<a href="#numpy.i-1476">1476</a>
<a href="#numpy.i-1477">1477</a>
<a href="#numpy.i-1478">1478</a>
<a href="#numpy.i-1479">1479</a>
<a href="#numpy.i-1480">1480</a>
<a href="#numpy.i-1481">1481</a>
<a href="#numpy.i-1482">1482</a>
<a href="#numpy.i-1483">1483</a>
<a href="#numpy.i-1484">1484</a>
<a href="#numpy.i-1485">1485</a>
<a href="#numpy.i-1486">1486</a>
<a href="#numpy.i-1487">1487</a>
<a href="#numpy.i-1488">1488</a>
<a href="#numpy.i-1489">1489</a>
<a href="#numpy.i-1490">1490</a>
<a href="#numpy.i-1491">1491</a>
<a href="#numpy.i-1492">1492</a>
<a href="#numpy.i-1493">1493</a>
<a href="#numpy.i-1494">1494</a>
<a href="#numpy.i-1495">1495</a>
<a href="#numpy.i-1496">1496</a>
<a href="#numpy.i-1497">1497</a>
<a href="#numpy.i-1498">1498</a>
<a href="#numpy.i-1499">1499</a>
<a href="#numpy.i-1500">1500</a>
<a href="#numpy.i-1501">1501</a>
<a href="#numpy.i-1502">1502</a>
<a href="#numpy.i-1503">1503</a>
<a href="#numpy.i-1504">1504</a>
<a href="#numpy.i-1505">1505</a>
<a href="#numpy.i-1506">1506</a>
<a href="#numpy.i-1507">1507</a>
<a href="#numpy.i-1508">1508</a>
<a href="#numpy.i-1509">1509</a>
<a href="#numpy.i-1510">1510</a>
<a href="#numpy.i-1511">1511</a>
<a href="#numpy.i-1512">1512</a>
<a href="#numpy.i-1513">1513</a>
<a href="#numpy.i-1514">1514</a>
<a href="#numpy.i-1515">1515</a>
<a href="#numpy.i-1516">1516</a>
<a href="#numpy.i-1517">1517</a>
<a href="#numpy.i-1518">1518</a>
<a href="#numpy.i-1519">1519</a>
<a href="#numpy.i-1520">1520</a>
<a href="#numpy.i-1521">1521</a>
<a href="#numpy.i-1522">1522</a>
<a href="#numpy.i-1523">1523</a>
<a href="#numpy.i-1524">1524</a>
<a href="#numpy.i-1525">1525</a>
<a href="#numpy.i-1526">1526</a>
<a href="#numpy.i-1527">1527</a>
<a href="#numpy.i-1528">1528</a>
<a href="#numpy.i-1529">1529</a>
<a href="#numpy.i-1530">1530</a>
<a href="#numpy.i-1531">1531</a>
<a href="#numpy.i-1532">1532</a>
<a href="#numpy.i-1533">1533</a>
<a href="#numpy.i-1534">1534</a>
<a href="#numpy.i-1535">1535</a>
<a href="#numpy.i-1536">1536</a>
<a href="#numpy.i-1537">1537</a>
<a href="#numpy.i-1538">1538</a>
<a href="#numpy.i-1539">1539</a>
<a href="#numpy.i-1540">1540</a>
<a href="#numpy.i-1541">1541</a>
<a href="#numpy.i-1542">1542</a>
<a href="#numpy.i-1543">1543</a>
<a href="#numpy.i-1544">1544</a>
<a href="#numpy.i-1545">1545</a>
<a href="#numpy.i-1546">1546</a>
<a href="#numpy.i-1547">1547</a>
<a href="#numpy.i-1548">1548</a>
<a href="#numpy.i-1549">1549</a>
<a href="#numpy.i-1550">1550</a>
<a href="#numpy.i-1551">1551</a>
<a href="#numpy.i-1552">1552</a>
<a href="#numpy.i-1553">1553</a>
<a href="#numpy.i-1554">1554</a>
<a href="#numpy.i-1555">1555</a>
<a href="#numpy.i-1556">1556</a>
<a href="#numpy.i-1557">1557</a>
<a href="#numpy.i-1558">1558</a>
<a href="#numpy.i-1559">1559</a>
<a href="#numpy.i-1560">1560</a>
<a href="#numpy.i-1561">1561</a>
<a href="#numpy.i-1562">1562</a>
<a href="#numpy.i-1563">1563</a>
<a href="#numpy.i-1564">1564</a>
<a href="#numpy.i-1565">1565</a>
<a href="#numpy.i-1566">1566</a>
<a href="#numpy.i-1567">1567</a>
<a href="#numpy.i-1568">1568</a>
<a href="#numpy.i-1569">1569</a>
<a href="#numpy.i-1570">1570</a>
<a href="#numpy.i-1571">1571</a>
<a href="#numpy.i-1572">1572</a>
<a href="#numpy.i-1573">1573</a>
<a href="#numpy.i-1574">1574</a>
<a href="#numpy.i-1575">1575</a>
<a href="#numpy.i-1576">1576</a>
<a href="#numpy.i-1577">1577</a>
<a href="#numpy.i-1578">1578</a>
<a href="#numpy.i-1579">1579</a>
<a href="#numpy.i-1580">1580</a>
<a href="#numpy.i-1581">1581</a>
<a href="#numpy.i-1582">1582</a>
<a href="#numpy.i-1583">1583</a>
<a href="#numpy.i-1584">1584</a>
<a href="#numpy.i-1585">1585</a>
<a href="#numpy.i-1586">1586</a>
<a href="#numpy.i-1587">1587</a>
<a href="#numpy.i-1588">1588</a>
<a href="#numpy.i-1589">1589</a>
<a href="#numpy.i-1590">1590</a>
<a href="#numpy.i-1591">1591</a>
<a href="#numpy.i-1592">1592</a>
<a href="#numpy.i-1593">1593</a>
<a href="#numpy.i-1594">1594</a>
<a href="#numpy.i-1595">1595</a>
<a href="#numpy.i-1596">1596</a>
<a href="#numpy.i-1597">1597</a>
<a href="#numpy.i-1598">1598</a>
<a href="#numpy.i-1599">1599</a>
<a href="#numpy.i-1600">1600</a>
<a href="#numpy.i-1601">1601</a>
<a href="#numpy.i-1602">1602</a>
<a href="#numpy.i-1603">1603</a>
<a href="#numpy.i-1604">1604</a>
<a href="#numpy.i-1605">1605</a>
<a href="#numpy.i-1606">1606</a>
<a href="#numpy.i-1607">1607</a>
<a href="#numpy.i-1608">1608</a>
<a href="#numpy.i-1609">1609</a>
<a href="#numpy.i-1610">1610</a>
<a href="#numpy.i-1611">1611</a>
<a href="#numpy.i-1612">1612</a>
<a href="#numpy.i-1613">1613</a>
<a href="#numpy.i-1614">1614</a>
<a href="#numpy.i-1615">1615</a>
<a href="#numpy.i-1616">1616</a>
<a href="#numpy.i-1617">1617</a>
<a href="#numpy.i-1618">1618</a>
<a href="#numpy.i-1619">1619</a>
<a href="#numpy.i-1620">1620</a>
<a href="#numpy.i-1621">1621</a>
<a href="#numpy.i-1622">1622</a>
<a href="#numpy.i-1623">1623</a>
<a href="#numpy.i-1624">1624</a>
<a href="#numpy.i-1625">1625</a>
<a href="#numpy.i-1626">1626</a>
<a href="#numpy.i-1627">1627</a>
<a href="#numpy.i-1628">1628</a>
<a href="#numpy.i-1629">1629</a>
<a href="#numpy.i-1630">1630</a>
<a href="#numpy.i-1631">1631</a>
<a href="#numpy.i-1632">1632</a>
<a href="#numpy.i-1633">1633</a>
<a href="#numpy.i-1634">1634</a>
<a href="#numpy.i-1635">1635</a>
<a href="#numpy.i-1636">1636</a>
<a href="#numpy.i-1637">1637</a>
<a href="#numpy.i-1638">1638</a>
<a href="#numpy.i-1639">1639</a>
<a href="#numpy.i-1640">1640</a>
<a href="#numpy.i-1641">1641</a>
<a href="#numpy.i-1642">1642</a>
<a href="#numpy.i-1643">1643</a>
<a href="#numpy.i-1644">1644</a>
<a href="#numpy.i-1645">1645</a>
<a href="#numpy.i-1646">1646</a>
<a href="#numpy.i-1647">1647</a>
<a href="#numpy.i-1648">1648</a>
<a href="#numpy.i-1649">1649</a>
<a href="#numpy.i-1650">1650</a>
<a href="#numpy.i-1651">1651</a>
<a href="#numpy.i-1652">1652</a>
<a href="#numpy.i-1653">1653</a>
<a href="#numpy.i-1654">1654</a>
<a href="#numpy.i-1655">1655</a>
<a href="#numpy.i-1656">1656</a>
<a href="#numpy.i-1657">1657</a>
<a href="#numpy.i-1658">1658</a>
<a href="#numpy.i-1659">1659</a>
<a href="#numpy.i-1660">1660</a>
<a href="#numpy.i-1661">1661</a>
<a href="#numpy.i-1662">1662</a>
<a href="#numpy.i-1663">1663</a>
<a href="#numpy.i-1664">1664</a>
<a href="#numpy.i-1665">1665</a>
<a href="#numpy.i-1666">1666</a>
<a href="#numpy.i-1667">1667</a>
<a href="#numpy.i-1668">1668</a>
<a href="#numpy.i-1669">1669</a>
<a href="#numpy.i-1670">1670</a>
<a href="#numpy.i-1671">1671</a>
<a href="#numpy.i-1672">1672</a>
<a href="#numpy.i-1673">1673</a>
<a href="#numpy.i-1674">1674</a>
<a href="#numpy.i-1675">1675</a>
<a href="#numpy.i-1676">1676</a>
<a href="#numpy.i-1677">1677</a>
<a href="#numpy.i-1678">1678</a>
<a href="#numpy.i-1679">1679</a>
<a href="#numpy.i-1680">1680</a>
<a href="#numpy.i-1681">1681</a>
<a href="#numpy.i-1682">1682</a>
<a href="#numpy.i-1683">1683</a>
<a href="#numpy.i-1684">1684</a>
<a href="#numpy.i-1685">1685</a>
<a href="#numpy.i-1686">1686</a>
<a href="#numpy.i-1687">1687</a>
<a href="#numpy.i-1688">1688</a>
<a href="#numpy.i-1689">1689</a>
<a href="#numpy.i-1690">1690</a>
<a href="#numpy.i-1691">1691</a>
<a href="#numpy.i-1692">1692</a>
<a href="#numpy.i-1693">1693</a>
<a href="#numpy.i-1694">1694</a>
<a href="#numpy.i-1695">1695</a>
<a href="#numpy.i-1696">1696</a>
<a href="#numpy.i-1697">1697</a>
<a href="#numpy.i-1698">1698</a>
<a href="#numpy.i-1699">1699</a>
<a href="#numpy.i-1700">1700</a>
<a href="#numpy.i-1701">1701</a>
<a href="#numpy.i-1702">1702</a>
<a href="#numpy.i-1703">1703</a>
<a href="#numpy.i-1704">1704</a>
<a href="#numpy.i-1705">1705</a>
<a href="#numpy.i-1706">1706</a>
<a href="#numpy.i-1707">1707</a>
<a href="#numpy.i-1708">1708</a>
<a href="#numpy.i-1709">1709</a>
<a href="#numpy.i-1710">1710</a>
<a href="#numpy.i-1711">1711</a>
<a href="#numpy.i-1712">1712</a>
<a href="#numpy.i-1713">1713</a>
<a href="#numpy.i-1714">1714</a>
<a href="#numpy.i-1715">1715</a>
<a href="#numpy.i-1716">1716</a>
<a href="#numpy.i-1717">1717</a>
<a href="#numpy.i-1718">1718</a>
<a href="#numpy.i-1719">1719</a>
<a href="#numpy.i-1720">1720</a>
<a href="#numpy.i-1721">1721</a>
<a href="#numpy.i-1722">1722</a>
<a href="#numpy.i-1723">1723</a>
<a href="#numpy.i-1724">1724</a>
<a href="#numpy.i-1725">1725</a>
<a href="#numpy.i-1726">1726</a>
<a href="#numpy.i-1727">1727</a>
<a href="#numpy.i-1728">1728</a>
<a href="#numpy.i-1729">1729</a>
<a href="#numpy.i-1730">1730</a>
<a href="#numpy.i-1731">1731</a>
<a href="#numpy.i-1732">1732</a>
<a href="#numpy.i-1733">1733</a>
<a href="#numpy.i-1734">1734</a>
<a href="#numpy.i-1735">1735</a>
<a href="#numpy.i-1736">1736</a>
<a href="#numpy.i-1737">1737</a>
<a href="#numpy.i-1738">1738</a>
<a href="#numpy.i-1739">1739</a>
<a href="#numpy.i-1740">1740</a>
<a href="#numpy.i-1741">1741</a>
<a href="#numpy.i-1742">1742</a>
<a href="#numpy.i-1743">1743</a>
<a href="#numpy.i-1744">1744</a>
<a href="#numpy.i-1745">1745</a>
<a href="#numpy.i-1746">1746</a>
<a href="#numpy.i-1747">1747</a>
<a href="#numpy.i-1748">1748</a>
<a href="#numpy.i-1749">1749</a>
<a href="#numpy.i-1750">1750</a>
<a href="#numpy.i-1751">1751</a>
<a href="#numpy.i-1752">1752</a>
<a href="#numpy.i-1753">1753</a>
<a href="#numpy.i-1754">1754</a>
<a href="#numpy.i-1755">1755</a>
<a href="#numpy.i-1756">1756</a>
<a href="#numpy.i-1757">1757</a>
<a href="#numpy.i-1758">1758</a>
<a href="#numpy.i-1759">1759</a>
<a href="#numpy.i-1760">1760</a>
<a href="#numpy.i-1761">1761</a>
<a href="#numpy.i-1762">1762</a>
<a href="#numpy.i-1763">1763</a>
<a href="#numpy.i-1764">1764</a>
<a href="#numpy.i-1765">1765</a>
<a href="#numpy.i-1766">1766</a>
<a href="#numpy.i-1767">1767</a>
<a href="#numpy.i-1768">1768</a>
<a href="#numpy.i-1769">1769</a>
<a href="#numpy.i-1770">1770</a>
<a href="#numpy.i-1771">1771</a>
<a href="#numpy.i-1772">1772</a>
<a href="#numpy.i-1773">1773</a>
<a href="#numpy.i-1774">1774</a>
<a href="#numpy.i-1775">1775</a>
<a href="#numpy.i-1776">1776</a>
<a href="#numpy.i-1777">1777</a>
<a href="#numpy.i-1778">1778</a>
<a href="#numpy.i-1779">1779</a>
<a href="#numpy.i-1780">1780</a>
<a href="#numpy.i-1781">1781</a>
<a href="#numpy.i-1782">1782</a>
<a href="#numpy.i-1783">1783</a>
<a href="#numpy.i-1784">1784</a>
<a href="#numpy.i-1785">1785</a>
<a href="#numpy.i-1786">1786</a>
<a href="#numpy.i-1787">1787</a>
<a href="#numpy.i-1788">1788</a>
<a href="#numpy.i-1789">1789</a>
<a href="#numpy.i-1790">1790</a>
<a href="#numpy.i-1791">1791</a>
<a href="#numpy.i-1792">1792</a>
<a href="#numpy.i-1793">1793</a>
<a href="#numpy.i-1794">1794</a>
<a href="#numpy.i-1795">1795</a>
<a href="#numpy.i-1796">1796</a>
<a href="#numpy.i-1797">1797</a>
<a href="#numpy.i-1798">1798</a>
<a href="#numpy.i-1799">1799</a>
<a href="#numpy.i-1800">1800</a>
<a href="#numpy.i-1801">1801</a>
<a href="#numpy.i-1802">1802</a>
<a href="#numpy.i-1803">1803</a>
<a href="#numpy.i-1804">1804</a>
<a href="#numpy.i-1805">1805</a>
<a href="#numpy.i-1806">1806</a>
<a href="#numpy.i-1807">1807</a>
<a href="#numpy.i-1808">1808</a>
<a href="#numpy.i-1809">1809</a>
<a href="#numpy.i-1810">1810</a>
<a href="#numpy.i-1811">1811</a>
<a href="#numpy.i-1812">1812</a>
<a href="#numpy.i-1813">1813</a>
<a href="#numpy.i-1814">1814</a>
<a href="#numpy.i-1815">1815</a>
<a href="#numpy.i-1816">1816</a>
<a href="#numpy.i-1817">1817</a>
<a href="#numpy.i-1818">1818</a>
<a href="#numpy.i-1819">1819</a>
<a href="#numpy.i-1820">1820</a>
<a href="#numpy.i-1821">1821</a>
<a href="#numpy.i-1822">1822</a>
<a href="#numpy.i-1823">1823</a>
<a href="#numpy.i-1824">1824</a>
<a href="#numpy.i-1825">1825</a>
<a href="#numpy.i-1826">1826</a>
<a href="#numpy.i-1827">1827</a>
<a href="#numpy.i-1828">1828</a>
<a href="#numpy.i-1829">1829</a>
<a href="#numpy.i-1830">1830</a>
<a href="#numpy.i-1831">1831</a>
<a href="#numpy.i-1832">1832</a>
<a href="#numpy.i-1833">1833</a>
<a href="#numpy.i-1834">1834</a>
<a href="#numpy.i-1835">1835</a>
<a href="#numpy.i-1836">1836</a>
<a href="#numpy.i-1837">1837</a>
<a href="#numpy.i-1838">1838</a>
<a href="#numpy.i-1839">1839</a>
<a href="#numpy.i-1840">1840</a>
<a href="#numpy.i-1841">1841</a>
<a href="#numpy.i-1842">1842</a>
<a href="#numpy.i-1843">1843</a>
<a href="#numpy.i-1844">1844</a>
<a href="#numpy.i-1845">1845</a>
<a href="#numpy.i-1846">1846</a>
<a href="#numpy.i-1847">1847</a>
<a href="#numpy.i-1848">1848</a>
<a href="#numpy.i-1849">1849</a>
<a href="#numpy.i-1850">1850</a>
<a href="#numpy.i-1851">1851</a>
<a href="#numpy.i-1852">1852</a>
<a href="#numpy.i-1853">1853</a>
<a href="#numpy.i-1854">1854</a>
<a href="#numpy.i-1855">1855</a>
<a href="#numpy.i-1856">1856</a>
<a href="#numpy.i-1857">1857</a>
<a href="#numpy.i-1858">1858</a>
<a href="#numpy.i-1859">1859</a>
<a href="#numpy.i-1860">1860</a>
<a href="#numpy.i-1861">1861</a>
<a href="#numpy.i-1862">1862</a>
<a href="#numpy.i-1863">1863</a>
<a href="#numpy.i-1864">1864</a>
<a href="#numpy.i-1865">1865</a>
<a href="#numpy.i-1866">1866</a>
<a href="#numpy.i-1867">1867</a>
<a href="#numpy.i-1868">1868</a>
<a href="#numpy.i-1869">1869</a>
<a href="#numpy.i-1870">1870</a>
<a href="#numpy.i-1871">1871</a>
<a href="#numpy.i-1872">1872</a>
<a href="#numpy.i-1873">1873</a>
<a href="#numpy.i-1874">1874</a>
<a href="#numpy.i-1875">1875</a>
<a href="#numpy.i-1876">1876</a>
<a href="#numpy.i-1877">1877</a>
<a href="#numpy.i-1878">1878</a>
<a href="#numpy.i-1879">1879</a>
<a href="#numpy.i-1880">1880</a>
<a href="#numpy.i-1881">1881</a>
<a href="#numpy.i-1882">1882</a>
<a href="#numpy.i-1883">1883</a>
<a href="#numpy.i-1884">1884</a>
<a href="#numpy.i-1885">1885</a>
<a href="#numpy.i-1886">1886</a>
<a href="#numpy.i-1887">1887</a>
<a href="#numpy.i-1888">1888</a>
<a href="#numpy.i-1889">1889</a>
<a href="#numpy.i-1890">1890</a>
<a href="#numpy.i-1891">1891</a>
<a href="#numpy.i-1892">1892</a>
<a href="#numpy.i-1893">1893</a>
<a href="#numpy.i-1894">1894</a>
<a href="#numpy.i-1895">1895</a>
<a href="#numpy.i-1896">1896</a>
<a href="#numpy.i-1897">1897</a>
<a href="#numpy.i-1898">1898</a>
<a href="#numpy.i-1899">1899</a>
<a href="#numpy.i-1900">1900</a>
<a href="#numpy.i-1901">1901</a>
<a href="#numpy.i-1902">1902</a>
<a href="#numpy.i-1903">1903</a>
<a href="#numpy.i-1904">1904</a>
<a href="#numpy.i-1905">1905</a>
<a href="#numpy.i-1906">1906</a>
<a href="#numpy.i-1907">1907</a>
<a href="#numpy.i-1908">1908</a>
<a href="#numpy.i-1909">1909</a>
<a href="#numpy.i-1910">1910</a>
<a href="#numpy.i-1911">1911</a>
<a href="#numpy.i-1912">1912</a>
<a href="#numpy.i-1913">1913</a>
<a href="#numpy.i-1914">1914</a>
<a href="#numpy.i-1915">1915</a>
<a href="#numpy.i-1916">1916</a>
<a href="#numpy.i-1917">1917</a>
<a href="#numpy.i-1918">1918</a>
<a href="#numpy.i-1919">1919</a>
<a href="#numpy.i-1920">1920</a>
<a href="#numpy.i-1921">1921</a>
<a href="#numpy.i-1922">1922</a>
<a href="#numpy.i-1923">1923</a>
<a href="#numpy.i-1924">1924</a>
<a href="#numpy.i-1925">1925</a>
<a href="#numpy.i-1926">1926</a>
<a href="#numpy.i-1927">1927</a>
<a href="#numpy.i-1928">1928</a>
<a href="#numpy.i-1929">1929</a>
<a href="#numpy.i-1930">1930</a>
<a href="#numpy.i-1931">1931</a>
<a href="#numpy.i-1932">1932</a>
<a href="#numpy.i-1933">1933</a>
<a href="#numpy.i-1934">1934</a>
<a href="#numpy.i-1935">1935</a>
<a href="#numpy.i-1936">1936</a>
<a href="#numpy.i-1937">1937</a>
<a href="#numpy.i-1938">1938</a>
<a href="#numpy.i-1939">1939</a>
<a href="#numpy.i-1940">1940</a>
<a href="#numpy.i-1941">1941</a>
<a href="#numpy.i-1942">1942</a>
<a href="#numpy.i-1943">1943</a>
<a href="#numpy.i-1944">1944</a>
<a href="#numpy.i-1945">1945</a>
<a href="#numpy.i-1946">1946</a>
<a href="#numpy.i-1947">1947</a>
<a href="#numpy.i-1948">1948</a>
<a href="#numpy.i-1949">1949</a>
<a href="#numpy.i-1950">1950</a>
<a href="#numpy.i-1951">1951</a>
<a href="#numpy.i-1952">1952</a>
<a href="#numpy.i-1953">1953</a>
<a href="#numpy.i-1954">1954</a>
<a href="#numpy.i-1955">1955</a>
<a href="#numpy.i-1956">1956</a>
<a href="#numpy.i-1957">1957</a>
<a href="#numpy.i-1958">1958</a>
<a href="#numpy.i-1959">1959</a>
<a href="#numpy.i-1960">1960</a>
<a href="#numpy.i-1961">1961</a>
<a href="#numpy.i-1962">1962</a>
<a href="#numpy.i-1963">1963</a>
<a href="#numpy.i-1964">1964</a>
<a href="#numpy.i-1965">1965</a>
<a href="#numpy.i-1966">1966</a>
<a href="#numpy.i-1967">1967</a>
<a href="#numpy.i-1968">1968</a>
<a href="#numpy.i-1969">1969</a>
<a href="#numpy.i-1970">1970</a>
<a href="#numpy.i-1971">1971</a>
<a href="#numpy.i-1972">1972</a>
<a href="#numpy.i-1973">1973</a>
<a href="#numpy.i-1974">1974</a>
<a href="#numpy.i-1975">1975</a>
<a href="#numpy.i-1976">1976</a>
<a href="#numpy.i-1977">1977</a>
<a href="#numpy.i-1978">1978</a>
<a href="#numpy.i-1979">1979</a>
<a href="#numpy.i-1980">1980</a>
<a href="#numpy.i-1981">1981</a>
<a href="#numpy.i-1982">1982</a>
<a href="#numpy.i-1983">1983</a>
<a href="#numpy.i-1984">1984</a>
<a href="#numpy.i-1985">1985</a>
<a href="#numpy.i-1986">1986</a>
<a href="#numpy.i-1987">1987</a>
<a href="#numpy.i-1988">1988</a>
<a href="#numpy.i-1989">1989</a>
<a href="#numpy.i-1990">1990</a>
<a href="#numpy.i-1991">1991</a>
<a href="#numpy.i-1992">1992</a>
<a href="#numpy.i-1993">1993</a>
<a href="#numpy.i-1994">1994</a>
<a href="#numpy.i-1995">1995</a>
<a href="#numpy.i-1996">1996</a>
<a href="#numpy.i-1997">1997</a>
<a href="#numpy.i-1998">1998</a>
<a href="#numpy.i-1999">1999</a>
<a href="#numpy.i-2000">2000</a>
<a href="#numpy.i-2001">2001</a>
<a href="#numpy.i-2002">2002</a>
<a href="#numpy.i-2003">2003</a>
<a href="#numpy.i-2004">2004</a>
<a href="#numpy.i-2005">2005</a>
<a href="#numpy.i-2006">2006</a>
<a href="#numpy.i-2007">2007</a>
<a href="#numpy.i-2008">2008</a>
<a href="#numpy.i-2009">2009</a>
<a href="#numpy.i-2010">2010</a>
<a href="#numpy.i-2011">2011</a>
<a href="#numpy.i-2012">2012</a>
<a href="#numpy.i-2013">2013</a>
<a href="#numpy.i-2014">2014</a>
<a href="#numpy.i-2015">2015</a>
<a href="#numpy.i-2016">2016</a>
<a href="#numpy.i-2017">2017</a>
<a href="#numpy.i-2018">2018</a>
<a href="#numpy.i-2019">2019</a>
<a href="#numpy.i-2020">2020</a>
<a href="#numpy.i-2021">2021</a>
<a href="#numpy.i-2022">2022</a>
<a href="#numpy.i-2023">2023</a>
<a href="#numpy.i-2024">2024</a>
<a href="#numpy.i-2025">2025</a>
<a href="#numpy.i-2026">2026</a>
<a href="#numpy.i-2027">2027</a>
<a href="#numpy.i-2028">2028</a>
<a href="#numpy.i-2029">2029</a>
<a href="#numpy.i-2030">2030</a>
<a href="#numpy.i-2031">2031</a>
<a href="#numpy.i-2032">2032</a>
<a href="#numpy.i-2033">2033</a>
<a href="#numpy.i-2034">2034</a>
<a href="#numpy.i-2035">2035</a>
<a href="#numpy.i-2036">2036</a>
<a href="#numpy.i-2037">2037</a>
<a href="#numpy.i-2038">2038</a>
<a href="#numpy.i-2039">2039</a>
<a href="#numpy.i-2040">2040</a>
<a href="#numpy.i-2041">2041</a>
<a href="#numpy.i-2042">2042</a>
<a href="#numpy.i-2043">2043</a>
<a href="#numpy.i-2044">2044</a>
<a href="#numpy.i-2045">2045</a>
<a href="#numpy.i-2046">2046</a>
<a href="#numpy.i-2047">2047</a>
<a href="#numpy.i-2048">2048</a>
<a href="#numpy.i-2049">2049</a>
<a href="#numpy.i-2050">2050</a>
<a href="#numpy.i-2051">2051</a>
<a href="#numpy.i-2052">2052</a>
<a href="#numpy.i-2053">2053</a>
<a href="#numpy.i-2054">2054</a>
<a href="#numpy.i-2055">2055</a>
<a href="#numpy.i-2056">2056</a>
<a href="#numpy.i-2057">2057</a>
<a href="#numpy.i-2058">2058</a>
<a href="#numpy.i-2059">2059</a>
<a href="#numpy.i-2060">2060</a>
<a href="#numpy.i-2061">2061</a>
<a href="#numpy.i-2062">2062</a>
<a href="#numpy.i-2063">2063</a>
<a href="#numpy.i-2064">2064</a>
<a href="#numpy.i-2065">2065</a>
<a href="#numpy.i-2066">2066</a>
<a href="#numpy.i-2067">2067</a>
<a href="#numpy.i-2068">2068</a>
<a href="#numpy.i-2069">2069</a>
<a href="#numpy.i-2070">2070</a>
<a href="#numpy.i-2071">2071</a>
<a href="#numpy.i-2072">2072</a>
<a href="#numpy.i-2073">2073</a>
<a href="#numpy.i-2074">2074</a>
<a href="#numpy.i-2075">2075</a>
<a href="#numpy.i-2076">2076</a>
<a href="#numpy.i-2077">2077</a>
<a href="#numpy.i-2078">2078</a>
<a href="#numpy.i-2079">2079</a>
<a href="#numpy.i-2080">2080</a>
<a href="#numpy.i-2081">2081</a>
<a href="#numpy.i-2082">2082</a>
<a href="#numpy.i-2083">2083</a>
<a href="#numpy.i-2084">2084</a>
<a href="#numpy.i-2085">2085</a>
<a href="#numpy.i-2086">2086</a>
<a href="#numpy.i-2087">2087</a>
<a href="#numpy.i-2088">2088</a>
<a href="#numpy.i-2089">2089</a>
<a href="#numpy.i-2090">2090</a>
<a href="#numpy.i-2091">2091</a>
<a href="#numpy.i-2092">2092</a>
<a href="#numpy.i-2093">2093</a>
<a href="#numpy.i-2094">2094</a>
<a href="#numpy.i-2095">2095</a>
<a href="#numpy.i-2096">2096</a>
<a href="#numpy.i-2097">2097</a>
<a href="#numpy.i-2098">2098</a>
<a href="#numpy.i-2099">2099</a>
<a href="#numpy.i-2100">2100</a>
<a href="#numpy.i-2101">2101</a>
<a href="#numpy.i-2102">2102</a>
<a href="#numpy.i-2103">2103</a>
<a href="#numpy.i-2104">2104</a>
<a href="#numpy.i-2105">2105</a>
<a href="#numpy.i-2106">2106</a>
<a href="#numpy.i-2107">2107</a>
<a href="#numpy.i-2108">2108</a>
<a href="#numpy.i-2109">2109</a>
<a href="#numpy.i-2110">2110</a>
<a href="#numpy.i-2111">2111</a>
<a href="#numpy.i-2112">2112</a>
<a href="#numpy.i-2113">2113</a>
<a href="#numpy.i-2114">2114</a>
<a href="#numpy.i-2115">2115</a>
<a href="#numpy.i-2116">2116</a>
<a href="#numpy.i-2117">2117</a>
<a href="#numpy.i-2118">2118</a>
<a href="#numpy.i-2119">2119</a>
<a href="#numpy.i-2120">2120</a>
<a href="#numpy.i-2121">2121</a>
<a href="#numpy.i-2122">2122</a>
<a href="#numpy.i-2123">2123</a>
<a href="#numpy.i-2124">2124</a>
<a href="#numpy.i-2125">2125</a>
<a href="#numpy.i-2126">2126</a>
<a href="#numpy.i-2127">2127</a>
<a href="#numpy.i-2128">2128</a>
<a href="#numpy.i-2129">2129</a>
<a href="#numpy.i-2130">2130</a>
<a href="#numpy.i-2131">2131</a>
<a href="#numpy.i-2132">2132</a>
<a href="#numpy.i-2133">2133</a>
<a href="#numpy.i-2134">2134</a>
<a href="#numpy.i-2135">2135</a>
<a href="#numpy.i-2136">2136</a>
<a href="#numpy.i-2137">2137</a>
<a href="#numpy.i-2138">2138</a>
<a href="#numpy.i-2139">2139</a>
<a href="#numpy.i-2140">2140</a>
<a href="#numpy.i-2141">2141</a>
<a href="#numpy.i-2142">2142</a>
<a href="#numpy.i-2143">2143</a>
<a href="#numpy.i-2144">2144</a>
<a href="#numpy.i-2145">2145</a>
<a href="#numpy.i-2146">2146</a>
<a href="#numpy.i-2147">2147</a>
<a href="#numpy.i-2148">2148</a>
<a href="#numpy.i-2149">2149</a>
<a href="#numpy.i-2150">2150</a>
<a href="#numpy.i-2151">2151</a>
<a href="#numpy.i-2152">2152</a>
<a href="#numpy.i-2153">2153</a>
<a href="#numpy.i-2154">2154</a>
<a href="#numpy.i-2155">2155</a>
<a href="#numpy.i-2156">2156</a>
<a href="#numpy.i-2157">2157</a>
<a href="#numpy.i-2158">2158</a>
<a href="#numpy.i-2159">2159</a>
<a href="#numpy.i-2160">2160</a>
<a href="#numpy.i-2161">2161</a>
<a href="#numpy.i-2162">2162</a>
<a href="#numpy.i-2163">2163</a>
<a href="#numpy.i-2164">2164</a>
<a href="#numpy.i-2165">2165</a>
<a href="#numpy.i-2166">2166</a>
<a href="#numpy.i-2167">2167</a>
<a href="#numpy.i-2168">2168</a>
<a href="#numpy.i-2169">2169</a>
<a href="#numpy.i-2170">2170</a>
<a href="#numpy.i-2171">2171</a>
<a href="#numpy.i-2172">2172</a>
<a href="#numpy.i-2173">2173</a>
<a href="#numpy.i-2174">2174</a>
<a href="#numpy.i-2175">2175</a>
<a href="#numpy.i-2176">2176</a>
<a href="#numpy.i-2177">2177</a>
<a href="#numpy.i-2178">2178</a>
<a href="#numpy.i-2179">2179</a>
<a href="#numpy.i-2180">2180</a>
<a href="#numpy.i-2181">2181</a>
<a href="#numpy.i-2182">2182</a>
<a href="#numpy.i-2183">2183</a>
<a href="#numpy.i-2184">2184</a>
<a href="#numpy.i-2185">2185</a>
<a href="#numpy.i-2186">2186</a>
<a href="#numpy.i-2187">2187</a>
<a href="#numpy.i-2188">2188</a>
<a href="#numpy.i-2189">2189</a>
<a href="#numpy.i-2190">2190</a>
<a href="#numpy.i-2191">2191</a>
<a href="#numpy.i-2192">2192</a>
<a href="#numpy.i-2193">2193</a>
<a href="#numpy.i-2194">2194</a>
<a href="#numpy.i-2195">2195</a>
<a href="#numpy.i-2196">2196</a>
<a href="#numpy.i-2197">2197</a>
<a href="#numpy.i-2198">2198</a>
<a href="#numpy.i-2199">2199</a>
<a href="#numpy.i-2200">2200</a>
<a href="#numpy.i-2201">2201</a>
<a href="#numpy.i-2202">2202</a>
<a href="#numpy.i-2203">2203</a>
<a href="#numpy.i-2204">2204</a>
<a href="#numpy.i-2205">2205</a>
<a href="#numpy.i-2206">2206</a>
<a href="#numpy.i-2207">2207</a>
<a href="#numpy.i-2208">2208</a>
<a href="#numpy.i-2209">2209</a>
<a href="#numpy.i-2210">2210</a>
<a href="#numpy.i-2211">2211</a>
<a href="#numpy.i-2212">2212</a>
<a href="#numpy.i-2213">2213</a>
<a href="#numpy.i-2214">2214</a>
<a href="#numpy.i-2215">2215</a>
<a href="#numpy.i-2216">2216</a>
<a href="#numpy.i-2217">2217</a>
<a href="#numpy.i-2218">2218</a>
<a href="#numpy.i-2219">2219</a>
<a href="#numpy.i-2220">2220</a>
<a href="#numpy.i-2221">2221</a>
<a href="#numpy.i-2222">2222</a>
<a href="#numpy.i-2223">2223</a>
<a href="#numpy.i-2224">2224</a>
<a href="#numpy.i-2225">2225</a>
<a href="#numpy.i-2226">2226</a>
<a href="#numpy.i-2227">2227</a>
<a href="#numpy.i-2228">2228</a>
<a href="#numpy.i-2229">2229</a>
<a href="#numpy.i-2230">2230</a>
<a href="#numpy.i-2231">2231</a>
<a href="#numpy.i-2232">2232</a>
<a href="#numpy.i-2233">2233</a>
<a href="#numpy.i-2234">2234</a>
<a href="#numpy.i-2235">2235</a>
<a href="#numpy.i-2236">2236</a>
<a href="#numpy.i-2237">2237</a>
<a href="#numpy.i-2238">2238</a>
<a href="#numpy.i-2239">2239</a>
<a href="#numpy.i-2240">2240</a>
<a href="#numpy.i-2241">2241</a>
<a href="#numpy.i-2242">2242</a>
<a href="#numpy.i-2243">2243</a>
<a href="#numpy.i-2244">2244</a>
<a href="#numpy.i-2245">2245</a>
<a href="#numpy.i-2246">2246</a>
<a href="#numpy.i-2247">2247</a>
<a href="#numpy.i-2248">2248</a>
<a href="#numpy.i-2249">2249</a>
<a href="#numpy.i-2250">2250</a>
<a href="#numpy.i-2251">2251</a>
<a href="#numpy.i-2252">2252</a>
<a href="#numpy.i-2253">2253</a>
<a href="#numpy.i-2254">2254</a>
<a href="#numpy.i-2255">2255</a>
<a href="#numpy.i-2256">2256</a>
<a href="#numpy.i-2257">2257</a>
<a href="#numpy.i-2258">2258</a>
<a href="#numpy.i-2259">2259</a>
<a href="#numpy.i-2260">2260</a>
<a href="#numpy.i-2261">2261</a>
<a href="#numpy.i-2262">2262</a>
<a href="#numpy.i-2263">2263</a>
<a href="#numpy.i-2264">2264</a>
<a href="#numpy.i-2265">2265</a>
<a href="#numpy.i-2266">2266</a>
<a href="#numpy.i-2267">2267</a>
<a href="#numpy.i-2268">2268</a>
<a href="#numpy.i-2269">2269</a>
<a href="#numpy.i-2270">2270</a>
<a href="#numpy.i-2271">2271</a>
<a href="#numpy.i-2272">2272</a>
<a href="#numpy.i-2273">2273</a>
<a href="#numpy.i-2274">2274</a>
<a href="#numpy.i-2275">2275</a>
<a href="#numpy.i-2276">2276</a>
<a href="#numpy.i-2277">2277</a>
<a href="#numpy.i-2278">2278</a>
<a href="#numpy.i-2279">2279</a>
<a href="#numpy.i-2280">2280</a>
<a href="#numpy.i-2281">2281</a>
<a href="#numpy.i-2282">2282</a>
<a href="#numpy.i-2283">2283</a>
<a href="#numpy.i-2284">2284</a>
<a href="#numpy.i-2285">2285</a>
<a href="#numpy.i-2286">2286</a>
<a href="#numpy.i-2287">2287</a>
<a href="#numpy.i-2288">2288</a>
<a href="#numpy.i-2289">2289</a>
<a href="#numpy.i-2290">2290</a>
<a href="#numpy.i-2291">2291</a>
<a href="#numpy.i-2292">2292</a>
<a href="#numpy.i-2293">2293</a>
<a href="#numpy.i-2294">2294</a>
<a href="#numpy.i-2295">2295</a>
<a href="#numpy.i-2296">2296</a>
<a href="#numpy.i-2297">2297</a>
<a href="#numpy.i-2298">2298</a>
<a href="#numpy.i-2299">2299</a>
<a href="#numpy.i-2300">2300</a>
<a href="#numpy.i-2301">2301</a>
<a href="#numpy.i-2302">2302</a>
<a href="#numpy.i-2303">2303</a>
<a href="#numpy.i-2304">2304</a>
<a href="#numpy.i-2305">2305</a>
<a href="#numpy.i-2306">2306</a>
<a href="#numpy.i-2307">2307</a>
<a href="#numpy.i-2308">2308</a>
<a href="#numpy.i-2309">2309</a>
<a href="#numpy.i-2310">2310</a>
<a href="#numpy.i-2311">2311</a>
<a href="#numpy.i-2312">2312</a>
<a href="#numpy.i-2313">2313</a>
<a href="#numpy.i-2314">2314</a>
<a href="#numpy.i-2315">2315</a>
<a href="#numpy.i-2316">2316</a>
<a href="#numpy.i-2317">2317</a>
<a href="#numpy.i-2318">2318</a>
<a href="#numpy.i-2319">2319</a>
<a href="#numpy.i-2320">2320</a>
<a href="#numpy.i-2321">2321</a>
<a href="#numpy.i-2322">2322</a>
<a href="#numpy.i-2323">2323</a>
<a href="#numpy.i-2324">2324</a>
<a href="#numpy.i-2325">2325</a>
<a href="#numpy.i-2326">2326</a>
<a href="#numpy.i-2327">2327</a>
<a href="#numpy.i-2328">2328</a>
<a href="#numpy.i-2329">2329</a>
<a href="#numpy.i-2330">2330</a>
<a href="#numpy.i-2331">2331</a>
<a href="#numpy.i-2332">2332</a>
<a href="#numpy.i-2333">2333</a>
<a href="#numpy.i-2334">2334</a>
<a href="#numpy.i-2335">2335</a>
<a href="#numpy.i-2336">2336</a>
<a href="#numpy.i-2337">2337</a>
<a href="#numpy.i-2338">2338</a>
<a href="#numpy.i-2339">2339</a>
<a href="#numpy.i-2340">2340</a>
<a href="#numpy.i-2341">2341</a>
<a href="#numpy.i-2342">2342</a>
<a href="#numpy.i-2343">2343</a>
<a href="#numpy.i-2344">2344</a>
<a href="#numpy.i-2345">2345</a>
<a href="#numpy.i-2346">2346</a>
<a href="#numpy.i-2347">2347</a>
<a href="#numpy.i-2348">2348</a>
<a href="#numpy.i-2349">2349</a>
<a href="#numpy.i-2350">2350</a>
<a href="#numpy.i-2351">2351</a>
<a href="#numpy.i-2352">2352</a>
<a href="#numpy.i-2353">2353</a>
<a href="#numpy.i-2354">2354</a>
<a href="#numpy.i-2355">2355</a>
<a href="#numpy.i-2356">2356</a>
<a href="#numpy.i-2357">2357</a>
<a href="#numpy.i-2358">2358</a>
<a href="#numpy.i-2359">2359</a>
<a href="#numpy.i-2360">2360</a>
<a href="#numpy.i-2361">2361</a>
<a href="#numpy.i-2362">2362</a>
<a href="#numpy.i-2363">2363</a>
<a href="#numpy.i-2364">2364</a>
<a href="#numpy.i-2365">2365</a>
<a href="#numpy.i-2366">2366</a>
<a href="#numpy.i-2367">2367</a>
<a href="#numpy.i-2368">2368</a>
<a href="#numpy.i-2369">2369</a>
<a href="#numpy.i-2370">2370</a>
<a href="#numpy.i-2371">2371</a>
<a href="#numpy.i-2372">2372</a>
<a href="#numpy.i-2373">2373</a>
<a href="#numpy.i-2374">2374</a>
<a href="#numpy.i-2375">2375</a>
<a href="#numpy.i-2376">2376</a>
<a href="#numpy.i-2377">2377</a>
<a href="#numpy.i-2378">2378</a>
<a href="#numpy.i-2379">2379</a>
<a href="#numpy.i-2380">2380</a>
<a href="#numpy.i-2381">2381</a>
<a href="#numpy.i-2382">2382</a>
<a href="#numpy.i-2383">2383</a>
<a href="#numpy.i-2384">2384</a>
<a href="#numpy.i-2385">2385</a>
<a href="#numpy.i-2386">2386</a>
<a href="#numpy.i-2387">2387</a>
<a href="#numpy.i-2388">2388</a>
<a href="#numpy.i-2389">2389</a>
<a href="#numpy.i-2390">2390</a>
<a href="#numpy.i-2391">2391</a>
<a href="#numpy.i-2392">2392</a>
<a href="#numpy.i-2393">2393</a>
<a href="#numpy.i-2394">2394</a>
<a href="#numpy.i-2395">2395</a>
<a href="#numpy.i-2396">2396</a>
<a href="#numpy.i-2397">2397</a>
<a href="#numpy.i-2398">2398</a>
<a href="#numpy.i-2399">2399</a>
<a href="#numpy.i-2400">2400</a>
<a href="#numpy.i-2401">2401</a>
<a href="#numpy.i-2402">2402</a>
<a href="#numpy.i-2403">2403</a>
<a href="#numpy.i-2404">2404</a>
<a href="#numpy.i-2405">2405</a>
<a href="#numpy.i-2406">2406</a>
<a href="#numpy.i-2407">2407</a>
<a href="#numpy.i-2408">2408</a>
<a href="#numpy.i-2409">2409</a>
<a href="#numpy.i-2410">2410</a>
<a href="#numpy.i-2411">2411</a>
<a href="#numpy.i-2412">2412</a>
<a href="#numpy.i-2413">2413</a>
<a href="#numpy.i-2414">2414</a>
<a href="#numpy.i-2415">2415</a>
<a href="#numpy.i-2416">2416</a>
<a href="#numpy.i-2417">2417</a>
<a href="#numpy.i-2418">2418</a>
<a href="#numpy.i-2419">2419</a>
<a href="#numpy.i-2420">2420</a>
<a href="#numpy.i-2421">2421</a>
<a href="#numpy.i-2422">2422</a>
<a href="#numpy.i-2423">2423</a>
<a href="#numpy.i-2424">2424</a>
<a href="#numpy.i-2425">2425</a>
<a href="#numpy.i-2426">2426</a>
<a href="#numpy.i-2427">2427</a>
<a href="#numpy.i-2428">2428</a>
<a href="#numpy.i-2429">2429</a>
<a href="#numpy.i-2430">2430</a>
<a href="#numpy.i-2431">2431</a>
<a href="#numpy.i-2432">2432</a>
<a href="#numpy.i-2433">2433</a>
<a href="#numpy.i-2434">2434</a>
<a href="#numpy.i-2435">2435</a>
<a href="#numpy.i-2436">2436</a>
<a href="#numpy.i-2437">2437</a>
<a href="#numpy.i-2438">2438</a>
<a href="#numpy.i-2439">2439</a>
<a href="#numpy.i-2440">2440</a>
<a href="#numpy.i-2441">2441</a>
<a href="#numpy.i-2442">2442</a>
<a href="#numpy.i-2443">2443</a>
<a href="#numpy.i-2444">2444</a>
<a href="#numpy.i-2445">2445</a>
<a href="#numpy.i-2446">2446</a>
<a href="#numpy.i-2447">2447</a>
<a href="#numpy.i-2448">2448</a>
<a href="#numpy.i-2449">2449</a>
<a href="#numpy.i-2450">2450</a>
<a href="#numpy.i-2451">2451</a>
<a href="#numpy.i-2452">2452</a>
<a href="#numpy.i-2453">2453</a>
<a href="#numpy.i-2454">2454</a>
<a href="#numpy.i-2455">2455</a>
<a href="#numpy.i-2456">2456</a>
<a href="#numpy.i-2457">2457</a>
<a href="#numpy.i-2458">2458</a>
<a href="#numpy.i-2459">2459</a>
<a href="#numpy.i-2460">2460</a>
<a href="#numpy.i-2461">2461</a>
<a href="#numpy.i-2462">2462</a>
<a href="#numpy.i-2463">2463</a>
<a href="#numpy.i-2464">2464</a>
<a href="#numpy.i-2465">2465</a>
<a href="#numpy.i-2466">2466</a>
<a href="#numpy.i-2467">2467</a>
<a href="#numpy.i-2468">2468</a>
<a href="#numpy.i-2469">2469</a>
<a href="#numpy.i-2470">2470</a>
<a href="#numpy.i-2471">2471</a>
<a href="#numpy.i-2472">2472</a>
<a href="#numpy.i-2473">2473</a>
<a href="#numpy.i-2474">2474</a>
<a href="#numpy.i-2475">2475</a>
<a href="#numpy.i-2476">2476</a>
<a href="#numpy.i-2477">2477</a>
<a href="#numpy.i-2478">2478</a>
<a href="#numpy.i-2479">2479</a>
<a href="#numpy.i-2480">2480</a>
<a href="#numpy.i-2481">2481</a>
<a href="#numpy.i-2482">2482</a>
<a href="#numpy.i-2483">2483</a>
<a href="#numpy.i-2484">2484</a>
<a href="#numpy.i-2485">2485</a>
<a href="#numpy.i-2486">2486</a>
<a href="#numpy.i-2487">2487</a>
<a href="#numpy.i-2488">2488</a>
<a href="#numpy.i-2489">2489</a>
<a href="#numpy.i-2490">2490</a>
<a href="#numpy.i-2491">2491</a>
<a href="#numpy.i-2492">2492</a>
<a href="#numpy.i-2493">2493</a>
<a href="#numpy.i-2494">2494</a>
<a href="#numpy.i-2495">2495</a>
<a href="#numpy.i-2496">2496</a>
<a href="#numpy.i-2497">2497</a>
<a href="#numpy.i-2498">2498</a>
<a href="#numpy.i-2499">2499</a>
<a href="#numpy.i-2500">2500</a>
<a href="#numpy.i-2501">2501</a>
<a href="#numpy.i-2502">2502</a>
<a href="#numpy.i-2503">2503</a>
<a href="#numpy.i-2504">2504</a>
<a href="#numpy.i-2505">2505</a>
<a href="#numpy.i-2506">2506</a>
<a href="#numpy.i-2507">2507</a>
<a href="#numpy.i-2508">2508</a>
<a href="#numpy.i-2509">2509</a>
<a href="#numpy.i-2510">2510</a>
<a href="#numpy.i-2511">2511</a>
<a href="#numpy.i-2512">2512</a>
<a href="#numpy.i-2513">2513</a>
<a href="#numpy.i-2514">2514</a>
<a href="#numpy.i-2515">2515</a>
<a href="#numpy.i-2516">2516</a>
<a href="#numpy.i-2517">2517</a>
<a href="#numpy.i-2518">2518</a>
<a href="#numpy.i-2519">2519</a>
<a href="#numpy.i-2520">2520</a>
<a href="#numpy.i-2521">2521</a>
<a href="#numpy.i-2522">2522</a>
<a href="#numpy.i-2523">2523</a>
<a href="#numpy.i-2524">2524</a>
<a href="#numpy.i-2525">2525</a>
<a href="#numpy.i-2526">2526</a>
<a href="#numpy.i-2527">2527</a>
<a href="#numpy.i-2528">2528</a>
<a href="#numpy.i-2529">2529</a>
<a href="#numpy.i-2530">2530</a>
<a href="#numpy.i-2531">2531</a>
<a href="#numpy.i-2532">2532</a>
<a href="#numpy.i-2533">2533</a>
<a href="#numpy.i-2534">2534</a>
<a href="#numpy.i-2535">2535</a>
<a href="#numpy.i-2536">2536</a>
<a href="#numpy.i-2537">2537</a>
<a href="#numpy.i-2538">2538</a>
<a href="#numpy.i-2539">2539</a>
<a href="#numpy.i-2540">2540</a>
<a href="#numpy.i-2541">2541</a>
<a href="#numpy.i-2542">2542</a>
<a href="#numpy.i-2543">2543</a>
<a href="#numpy.i-2544">2544</a>
<a href="#numpy.i-2545">2545</a>
<a href="#numpy.i-2546">2546</a>
<a href="#numpy.i-2547">2547</a>
<a href="#numpy.i-2548">2548</a>
<a href="#numpy.i-2549">2549</a>
<a href="#numpy.i-2550">2550</a>
<a href="#numpy.i-2551">2551</a>
<a href="#numpy.i-2552">2552</a>
<a href="#numpy.i-2553">2553</a>
<a href="#numpy.i-2554">2554</a>
<a href="#numpy.i-2555">2555</a>
<a href="#numpy.i-2556">2556</a>
<a href="#numpy.i-2557">2557</a>
<a href="#numpy.i-2558">2558</a>
<a href="#numpy.i-2559">2559</a>
<a href="#numpy.i-2560">2560</a>
<a href="#numpy.i-2561">2561</a>
<a href="#numpy.i-2562">2562</a>
<a href="#numpy.i-2563">2563</a>
<a href="#numpy.i-2564">2564</a>
<a href="#numpy.i-2565">2565</a>
<a href="#numpy.i-2566">2566</a>
<a href="#numpy.i-2567">2567</a>
<a href="#numpy.i-2568">2568</a>
<a href="#numpy.i-2569">2569</a>
<a href="#numpy.i-2570">2570</a>
<a href="#numpy.i-2571">2571</a>
<a href="#numpy.i-2572">2572</a>
<a href="#numpy.i-2573">2573</a>
<a href="#numpy.i-2574">2574</a>
<a href="#numpy.i-2575">2575</a>
<a href="#numpy.i-2576">2576</a>
<a href="#numpy.i-2577">2577</a>
<a href="#numpy.i-2578">2578</a>
<a href="#numpy.i-2579">2579</a>
<a href="#numpy.i-2580">2580</a>
<a href="#numpy.i-2581">2581</a>
<a href="#numpy.i-2582">2582</a>
<a href="#numpy.i-2583">2583</a>
<a href="#numpy.i-2584">2584</a>
<a href="#numpy.i-2585">2585</a>
<a href="#numpy.i-2586">2586</a>
<a href="#numpy.i-2587">2587</a>
<a href="#numpy.i-2588">2588</a>
<a href="#numpy.i-2589">2589</a>
<a href="#numpy.i-2590">2590</a>
<a href="#numpy.i-2591">2591</a>
<a href="#numpy.i-2592">2592</a>
<a href="#numpy.i-2593">2593</a>
<a href="#numpy.i-2594">2594</a>
<a href="#numpy.i-2595">2595</a>
<a href="#numpy.i-2596">2596</a>
<a href="#numpy.i-2597">2597</a>
<a href="#numpy.i-2598">2598</a>
<a href="#numpy.i-2599">2599</a>
<a href="#numpy.i-2600">2600</a>
<a href="#numpy.i-2601">2601</a>
<a href="#numpy.i-2602">2602</a>
<a href="#numpy.i-2603">2603</a>
<a href="#numpy.i-2604">2604</a>
<a href="#numpy.i-2605">2605</a>
<a href="#numpy.i-2606">2606</a>
<a href="#numpy.i-2607">2607</a>
<a href="#numpy.i-2608">2608</a>
<a href="#numpy.i-2609">2609</a>
<a href="#numpy.i-2610">2610</a>
<a href="#numpy.i-2611">2611</a>
<a href="#numpy.i-2612">2612</a>
<a href="#numpy.i-2613">2613</a>
<a href="#numpy.i-2614">2614</a>
<a href="#numpy.i-2615">2615</a>
<a href="#numpy.i-2616">2616</a>
<a href="#numpy.i-2617">2617</a>
<a href="#numpy.i-2618">2618</a>
<a href="#numpy.i-2619">2619</a>
<a href="#numpy.i-2620">2620</a>
<a href="#numpy.i-2621">2621</a>
<a href="#numpy.i-2622">2622</a>
<a href="#numpy.i-2623">2623</a>
<a href="#numpy.i-2624">2624</a>
<a href="#numpy.i-2625">2625</a>
<a href="#numpy.i-2626">2626</a>
<a href="#numpy.i-2627">2627</a>
<a href="#numpy.i-2628">2628</a>
<a href="#numpy.i-2629">2629</a>
<a href="#numpy.i-2630">2630</a>
<a href="#numpy.i-2631">2631</a>
<a href="#numpy.i-2632">2632</a>
<a href="#numpy.i-2633">2633</a>
<a href="#numpy.i-2634">2634</a>
<a href="#numpy.i-2635">2635</a>
<a href="#numpy.i-2636">2636</a>
<a href="#numpy.i-2637">2637</a>
<a href="#numpy.i-2638">2638</a>
<a href="#numpy.i-2639">2639</a>
<a href="#numpy.i-2640">2640</a>
<a href="#numpy.i-2641">2641</a>
<a href="#numpy.i-2642">2642</a>
<a href="#numpy.i-2643">2643</a>
<a href="#numpy.i-2644">2644</a>
<a href="#numpy.i-2645">2645</a>
<a href="#numpy.i-2646">2646</a>
<a href="#numpy.i-2647">2647</a>
<a href="#numpy.i-2648">2648</a>
<a href="#numpy.i-2649">2649</a>
<a href="#numpy.i-2650">2650</a>
<a href="#numpy.i-2651">2651</a>
<a href="#numpy.i-2652">2652</a>
<a href="#numpy.i-2653">2653</a>
<a href="#numpy.i-2654">2654</a>
<a href="#numpy.i-2655">2655</a>
<a href="#numpy.i-2656">2656</a>
<a href="#numpy.i-2657">2657</a>
<a href="#numpy.i-2658">2658</a>
<a href="#numpy.i-2659">2659</a>
<a href="#numpy.i-2660">2660</a>
<a href="#numpy.i-2661">2661</a>
<a href="#numpy.i-2662">2662</a>
<a href="#numpy.i-2663">2663</a>
<a href="#numpy.i-2664">2664</a>
<a href="#numpy.i-2665">2665</a>
<a href="#numpy.i-2666">2666</a>
<a href="#numpy.i-2667">2667</a>
<a href="#numpy.i-2668">2668</a>
<a href="#numpy.i-2669">2669</a>
<a href="#numpy.i-2670">2670</a>
<a href="#numpy.i-2671">2671</a>
<a href="#numpy.i-2672">2672</a>
<a href="#numpy.i-2673">2673</a>
<a href="#numpy.i-2674">2674</a>
<a href="#numpy.i-2675">2675</a>
<a href="#numpy.i-2676">2676</a>
<a href="#numpy.i-2677">2677</a>
<a href="#numpy.i-2678">2678</a>
<a href="#numpy.i-2679">2679</a>
<a href="#numpy.i-2680">2680</a>
<a href="#numpy.i-2681">2681</a>
<a href="#numpy.i-2682">2682</a>
<a href="#numpy.i-2683">2683</a>
<a href="#numpy.i-2684">2684</a>
<a href="#numpy.i-2685">2685</a>
<a href="#numpy.i-2686">2686</a>
<a href="#numpy.i-2687">2687</a>
<a href="#numpy.i-2688">2688</a>
<a href="#numpy.i-2689">2689</a>
<a href="#numpy.i-2690">2690</a>
<a href="#numpy.i-2691">2691</a>
<a href="#numpy.i-2692">2692</a>
<a href="#numpy.i-2693">2693</a>
<a href="#numpy.i-2694">2694</a>
<a href="#numpy.i-2695">2695</a>
<a href="#numpy.i-2696">2696</a>
<a href="#numpy.i-2697">2697</a>
<a href="#numpy.i-2698">2698</a>
<a href="#numpy.i-2699">2699</a>
<a href="#numpy.i-2700">2700</a>
<a href="#numpy.i-2701">2701</a>
<a href="#numpy.i-2702">2702</a>
<a href="#numpy.i-2703">2703</a>
<a href="#numpy.i-2704">2704</a>
<a href="#numpy.i-2705">2705</a>
<a href="#numpy.i-2706">2706</a>
<a href="#numpy.i-2707">2707</a>
<a href="#numpy.i-2708">2708</a>
<a href="#numpy.i-2709">2709</a>
<a href="#numpy.i-2710">2710</a>
<a href="#numpy.i-2711">2711</a>
<a href="#numpy.i-2712">2712</a>
<a href="#numpy.i-2713">2713</a>
<a href="#numpy.i-2714">2714</a>
<a href="#numpy.i-2715">2715</a>
<a href="#numpy.i-2716">2716</a>
<a href="#numpy.i-2717">2717</a>
<a href="#numpy.i-2718">2718</a>
<a href="#numpy.i-2719">2719</a>
<a href="#numpy.i-2720">2720</a>
<a href="#numpy.i-2721">2721</a>
<a href="#numpy.i-2722">2722</a>
<a href="#numpy.i-2723">2723</a>
<a href="#numpy.i-2724">2724</a>
<a href="#numpy.i-2725">2725</a>
<a href="#numpy.i-2726">2726</a>
<a href="#numpy.i-2727">2727</a>
<a href="#numpy.i-2728">2728</a>
<a href="#numpy.i-2729">2729</a>
<a href="#numpy.i-2730">2730</a>
<a href="#numpy.i-2731">2731</a>
<a href="#numpy.i-2732">2732</a>
<a href="#numpy.i-2733">2733</a>
<a href="#numpy.i-2734">2734</a>
<a href="#numpy.i-2735">2735</a>
<a href="#numpy.i-2736">2736</a>
<a href="#numpy.i-2737">2737</a>
<a href="#numpy.i-2738">2738</a>
<a href="#numpy.i-2739">2739</a>
<a href="#numpy.i-2740">2740</a>
<a href="#numpy.i-2741">2741</a>
<a href="#numpy.i-2742">2742</a>
<a href="#numpy.i-2743">2743</a>
<a href="#numpy.i-2744">2744</a>
<a href="#numpy.i-2745">2745</a>
<a href="#numpy.i-2746">2746</a>
<a href="#numpy.i-2747">2747</a>
<a href="#numpy.i-2748">2748</a>
<a href="#numpy.i-2749">2749</a>
<a href="#numpy.i-2750">2750</a>
<a href="#numpy.i-2751">2751</a>
<a href="#numpy.i-2752">2752</a>
<a href="#numpy.i-2753">2753</a>
<a href="#numpy.i-2754">2754</a>
<a href="#numpy.i-2755">2755</a>
<a href="#numpy.i-2756">2756</a>
<a href="#numpy.i-2757">2757</a>
<a href="#numpy.i-2758">2758</a>
<a href="#numpy.i-2759">2759</a>
<a href="#numpy.i-2760">2760</a>
<a href="#numpy.i-2761">2761</a>
<a href="#numpy.i-2762">2762</a>
<a href="#numpy.i-2763">2763</a>
<a href="#numpy.i-2764">2764</a>
<a href="#numpy.i-2765">2765</a>
<a href="#numpy.i-2766">2766</a>
<a href="#numpy.i-2767">2767</a>
<a href="#numpy.i-2768">2768</a>
<a href="#numpy.i-2769">2769</a>
<a href="#numpy.i-2770">2770</a>
<a href="#numpy.i-2771">2771</a>
<a href="#numpy.i-2772">2772</a>
<a href="#numpy.i-2773">2773</a>
<a href="#numpy.i-2774">2774</a>
<a href="#numpy.i-2775">2775</a>
<a href="#numpy.i-2776">2776</a>
<a href="#numpy.i-2777">2777</a>
<a href="#numpy.i-2778">2778</a>
<a href="#numpy.i-2779">2779</a>
<a href="#numpy.i-2780">2780</a>
<a href="#numpy.i-2781">2781</a>
<a href="#numpy.i-2782">2782</a>
<a href="#numpy.i-2783">2783</a>
<a href="#numpy.i-2784">2784</a>
<a href="#numpy.i-2785">2785</a>
<a href="#numpy.i-2786">2786</a>
<a href="#numpy.i-2787">2787</a>
<a href="#numpy.i-2788">2788</a>
<a href="#numpy.i-2789">2789</a>
<a href="#numpy.i-2790">2790</a>
<a href="#numpy.i-2791">2791</a>
<a href="#numpy.i-2792">2792</a>
<a href="#numpy.i-2793">2793</a>
<a href="#numpy.i-2794">2794</a>
<a href="#numpy.i-2795">2795</a>
<a href="#numpy.i-2796">2796</a>
<a href="#numpy.i-2797">2797</a>
<a href="#numpy.i-2798">2798</a>
<a href="#numpy.i-2799">2799</a>
<a href="#numpy.i-2800">2800</a>
<a href="#numpy.i-2801">2801</a>
<a href="#numpy.i-2802">2802</a>
<a href="#numpy.i-2803">2803</a>
<a href="#numpy.i-2804">2804</a>
<a href="#numpy.i-2805">2805</a>
<a href="#numpy.i-2806">2806</a>
<a href="#numpy.i-2807">2807</a>
<a href="#numpy.i-2808">2808</a>
<a href="#numpy.i-2809">2809</a>
<a href="#numpy.i-2810">2810</a>
<a href="#numpy.i-2811">2811</a>
<a href="#numpy.i-2812">2812</a>
<a href="#numpy.i-2813">2813</a>
<a href="#numpy.i-2814">2814</a>
<a href="#numpy.i-2815">2815</a>
<a href="#numpy.i-2816">2816</a>
<a href="#numpy.i-2817">2817</a>
<a href="#numpy.i-2818">2818</a>
<a href="#numpy.i-2819">2819</a>
<a href="#numpy.i-2820">2820</a>
<a href="#numpy.i-2821">2821</a>
<a href="#numpy.i-2822">2822</a>
<a href="#numpy.i-2823">2823</a>
<a href="#numpy.i-2824">2824</a>
<a href="#numpy.i-2825">2825</a>
<a href="#numpy.i-2826">2826</a>
<a href="#numpy.i-2827">2827</a>
<a href="#numpy.i-2828">2828</a>
<a href="#numpy.i-2829">2829</a>
<a href="#numpy.i-2830">2830</a>
<a href="#numpy.i-2831">2831</a>
<a href="#numpy.i-2832">2832</a>
<a href="#numpy.i-2833">2833</a>
<a href="#numpy.i-2834">2834</a>
<a href="#numpy.i-2835">2835</a>
<a href="#numpy.i-2836">2836</a>
<a href="#numpy.i-2837">2837</a>
<a href="#numpy.i-2838">2838</a>
<a href="#numpy.i-2839">2839</a>
<a href="#numpy.i-2840">2840</a>
<a href="#numpy.i-2841">2841</a>
<a href="#numpy.i-2842">2842</a>
<a href="#numpy.i-2843">2843</a>
<a href="#numpy.i-2844">2844</a>
<a href="#numpy.i-2845">2845</a>
<a href="#numpy.i-2846">2846</a>
<a href="#numpy.i-2847">2847</a>
<a href="#numpy.i-2848">2848</a>
<a href="#numpy.i-2849">2849</a>
<a href="#numpy.i-2850">2850</a>
<a href="#numpy.i-2851">2851</a>
<a href="#numpy.i-2852">2852</a>
<a href="#numpy.i-2853">2853</a>
<a href="#numpy.i-2854">2854</a>
<a href="#numpy.i-2855">2855</a>
<a href="#numpy.i-2856">2856</a>
<a href="#numpy.i-2857">2857</a>
<a href="#numpy.i-2858">2858</a>
<a href="#numpy.i-2859">2859</a>
<a href="#numpy.i-2860">2860</a>
<a href="#numpy.i-2861">2861</a>
<a href="#numpy.i-2862">2862</a>
<a href="#numpy.i-2863">2863</a>
<a href="#numpy.i-2864">2864</a>
<a href="#numpy.i-2865">2865</a>
<a href="#numpy.i-2866">2866</a>
<a href="#numpy.i-2867">2867</a>
<a href="#numpy.i-2868">2868</a>
<a href="#numpy.i-2869">2869</a>
<a href="#numpy.i-2870">2870</a>
<a href="#numpy.i-2871">2871</a>
<a href="#numpy.i-2872">2872</a>
<a href="#numpy.i-2873">2873</a>
<a href="#numpy.i-2874">2874</a>
<a href="#numpy.i-2875">2875</a>
<a href="#numpy.i-2876">2876</a>
<a href="#numpy.i-2877">2877</a>
<a href="#numpy.i-2878">2878</a>
<a href="#numpy.i-2879">2879</a>
<a href="#numpy.i-2880">2880</a>
<a href="#numpy.i-2881">2881</a>
<a href="#numpy.i-2882">2882</a>
<a href="#numpy.i-2883">2883</a>
<a href="#numpy.i-2884">2884</a>
<a href="#numpy.i-2885">2885</a>
<a href="#numpy.i-2886">2886</a>
<a href="#numpy.i-2887">2887</a>
<a href="#numpy.i-2888">2888</a>
<a href="#numpy.i-2889">2889</a>
<a href="#numpy.i-2890">2890</a>
<a href="#numpy.i-2891">2891</a>
<a href="#numpy.i-2892">2892</a>
<a href="#numpy.i-2893">2893</a>
<a href="#numpy.i-2894">2894</a>
<a href="#numpy.i-2895">2895</a>
<a href="#numpy.i-2896">2896</a>
<a href="#numpy.i-2897">2897</a>
<a href="#numpy.i-2898">2898</a>
<a href="#numpy.i-2899">2899</a>
<a href="#numpy.i-2900">2900</a>
<a href="#numpy.i-2901">2901</a>
<a href="#numpy.i-2902">2902</a>
<a href="#numpy.i-2903">2903</a>
<a href="#numpy.i-2904">2904</a>
<a href="#numpy.i-2905">2905</a>
<a href="#numpy.i-2906">2906</a>
<a href="#numpy.i-2907">2907</a>
<a href="#numpy.i-2908">2908</a>
<a href="#numpy.i-2909">2909</a>
<a href="#numpy.i-2910">2910</a>
<a href="#numpy.i-2911">2911</a>
<a href="#numpy.i-2912">2912</a>
<a href="#numpy.i-2913">2913</a>
<a href="#numpy.i-2914">2914</a>
<a href="#numpy.i-2915">2915</a>
<a href="#numpy.i-2916">2916</a>
<a href="#numpy.i-2917">2917</a>
<a href="#numpy.i-2918">2918</a>
<a href="#numpy.i-2919">2919</a>
<a href="#numpy.i-2920">2920</a>
<a href="#numpy.i-2921">2921</a>
<a href="#numpy.i-2922">2922</a>
<a href="#numpy.i-2923">2923</a>
<a href="#numpy.i-2924">2924</a>
<a href="#numpy.i-2925">2925</a>
<a href="#numpy.i-2926">2926</a>
<a href="#numpy.i-2927">2927</a>
<a href="#numpy.i-2928">2928</a>
<a href="#numpy.i-2929">2929</a>
<a href="#numpy.i-2930">2930</a>
<a href="#numpy.i-2931">2931</a>
<a href="#numpy.i-2932">2932</a>
<a href="#numpy.i-2933">2933</a>
<a href="#numpy.i-2934">2934</a>
<a href="#numpy.i-2935">2935</a>
<a href="#numpy.i-2936">2936</a>
<a href="#numpy.i-2937">2937</a>
<a href="#numpy.i-2938">2938</a>
<a href="#numpy.i-2939">2939</a>
<a href="#numpy.i-2940">2940</a>
<a href="#numpy.i-2941">2941</a>
<a href="#numpy.i-2942">2942</a>
<a href="#numpy.i-2943">2943</a>
<a href="#numpy.i-2944">2944</a>
<a href="#numpy.i-2945">2945</a>
<a href="#numpy.i-2946">2946</a>
<a href="#numpy.i-2947">2947</a>
<a href="#numpy.i-2948">2948</a>
<a href="#numpy.i-2949">2949</a>
<a href="#numpy.i-2950">2950</a>
<a href="#numpy.i-2951">2951</a>
<a href="#numpy.i-2952">2952</a>
<a href="#numpy.i-2953">2953</a>
<a href="#numpy.i-2954">2954</a>
<a href="#numpy.i-2955">2955</a>
<a href="#numpy.i-2956">2956</a>
<a href="#numpy.i-2957">2957</a>
<a href="#numpy.i-2958">2958</a>
<a href="#numpy.i-2959">2959</a>
<a href="#numpy.i-2960">2960</a>
<a href="#numpy.i-2961">2961</a>
<a href="#numpy.i-2962">2962</a>
<a href="#numpy.i-2963">2963</a>
<a href="#numpy.i-2964">2964</a>
<a href="#numpy.i-2965">2965</a>
<a href="#numpy.i-2966">2966</a>
<a href="#numpy.i-2967">2967</a>
<a href="#numpy.i-2968">2968</a>
<a href="#numpy.i-2969">2969</a>
<a href="#numpy.i-2970">2970</a>
<a href="#numpy.i-2971">2971</a>
<a href="#numpy.i-2972">2972</a>
<a href="#numpy.i-2973">2973</a>
<a href="#numpy.i-2974">2974</a>
<a href="#numpy.i-2975">2975</a>
<a href="#numpy.i-2976">2976</a>
<a href="#numpy.i-2977">2977</a>
<a href="#numpy.i-2978">2978</a>
<a href="#numpy.i-2979">2979</a>
<a href="#numpy.i-2980">2980</a>
<a href="#numpy.i-2981">2981</a>
<a href="#numpy.i-2982">2982</a>
<a href="#numpy.i-2983">2983</a>
<a href="#numpy.i-2984">2984</a>
<a href="#numpy.i-2985">2985</a>
<a href="#numpy.i-2986">2986</a>
<a href="#numpy.i-2987">2987</a>
<a href="#numpy.i-2988">2988</a>
<a href="#numpy.i-2989">2989</a>
<a href="#numpy.i-2990">2990</a>
<a href="#numpy.i-2991">2991</a>
<a href="#numpy.i-2992">2992</a>
<a href="#numpy.i-2993">2993</a>
<a href="#numpy.i-2994">2994</a>
<a href="#numpy.i-2995">2995</a>
<a href="#numpy.i-2996">2996</a>
<a href="#numpy.i-2997">2997</a>
<a href="#numpy.i-2998">2998</a>
<a href="#numpy.i-2999">2999</a>
<a href="#numpy.i-3000">3000</a>
<a href="#numpy.i-3001">3001</a>
<a href="#numpy.i-3002">3002</a>
<a href="#numpy.i-3003">3003</a>
<a href="#numpy.i-3004">3004</a>
<a href="#numpy.i-3005">3005</a>
<a href="#numpy.i-3006">3006</a>
<a href="#numpy.i-3007">3007</a>
<a href="#numpy.i-3008">3008</a>
<a href="#numpy.i-3009">3009</a>
<a href="#numpy.i-3010">3010</a>
<a href="#numpy.i-3011">3011</a>
<a href="#numpy.i-3012">3012</a>
<a href="#numpy.i-3013">3013</a>
<a href="#numpy.i-3014">3014</a>
<a href="#numpy.i-3015">3015</a>
<a href="#numpy.i-3016">3016</a>
<a href="#numpy.i-3017">3017</a>
<a href="#numpy.i-3018">3018</a>
<a href="#numpy.i-3019">3019</a>
<a href="#numpy.i-3020">3020</a>
<a href="#numpy.i-3021">3021</a>
<a href="#numpy.i-3022">3022</a>
<a href="#numpy.i-3023">3023</a>
<a href="#numpy.i-3024">3024</a>
<a href="#numpy.i-3025">3025</a>
<a href="#numpy.i-3026">3026</a>
<a href="#numpy.i-3027">3027</a>
<a href="#numpy.i-3028">3028</a>
<a href="#numpy.i-3029">3029</a>
<a href="#numpy.i-3030">3030</a>
<a href="#numpy.i-3031">3031</a>
<a href="#numpy.i-3032">3032</a>
<a href="#numpy.i-3033">3033</a>
<a href="#numpy.i-3034">3034</a>
<a href="#numpy.i-3035">3035</a>
<a href="#numpy.i-3036">3036</a>
<a href="#numpy.i-3037">3037</a>
<a href="#numpy.i-3038">3038</a>
<a href="#numpy.i-3039">3039</a>
<a href="#numpy.i-3040">3040</a>
<a href="#numpy.i-3041">3041</a>
<a href="#numpy.i-3042">3042</a>
<a href="#numpy.i-3043">3043</a>
<a href="#numpy.i-3044">3044</a>
<a href="#numpy.i-3045">3045</a>
<a href="#numpy.i-3046">3046</a>
<a href="#numpy.i-3047">3047</a>
<a href="#numpy.i-3048">3048</a>
<a href="#numpy.i-3049">3049</a>
<a href="#numpy.i-3050">3050</a>
<a href="#numpy.i-3051">3051</a>
<a href="#numpy.i-3052">3052</a>
<a href="#numpy.i-3053">3053</a>
<a href="#numpy.i-3054">3054</a>
<a href="#numpy.i-3055">3055</a>
<a href="#numpy.i-3056">3056</a>
<a href="#numpy.i-3057">3057</a>
<a href="#numpy.i-3058">3058</a>
<a href="#numpy.i-3059">3059</a>
<a href="#numpy.i-3060">3060</a>
<a href="#numpy.i-3061">3061</a>
<a href="#numpy.i-3062">3062</a>
<a href="#numpy.i-3063">3063</a>
<a href="#numpy.i-3064">3064</a>
<a href="#numpy.i-3065">3065</a>
<a href="#numpy.i-3066">3066</a>
<a href="#numpy.i-3067">3067</a>
<a href="#numpy.i-3068">3068</a>
<a href="#numpy.i-3069">3069</a>
<a href="#numpy.i-3070">3070</a>
<a href="#numpy.i-3071">3071</a>
<a href="#numpy.i-3072">3072</a>
<a href="#numpy.i-3073">3073</a>
<a href="#numpy.i-3074">3074</a>
<a href="#numpy.i-3075">3075</a>
<a href="#numpy.i-3076">3076</a>
<a href="#numpy.i-3077">3077</a>
<a href="#numpy.i-3078">3078</a>
<a href="#numpy.i-3079">3079</a>
<a href="#numpy.i-3080">3080</a>
<a href="#numpy.i-3081">3081</a>
<a href="#numpy.i-3082">3082</a>
<a href="#numpy.i-3083">3083</a>
<a href="#numpy.i-3084">3084</a>
<a href="#numpy.i-3085">3085</a>
</pre></div></td>
<td class="code"><div class="highlight"><pre>
<a name="numpy.i-1"></a>/* -*- C -*-  (not really, but good for syntax highlighting) */
<a name="numpy.i-2"></a>#ifdef SWIGPYTHON
<a name="numpy.i-3"></a>
<a name="numpy.i-4"></a>%{
<a name="numpy.i-5"></a>#ifndef SWIG_FILE_WITH_INIT
<a name="numpy.i-6"></a>#define NO_IMPORT_ARRAY
<a name="numpy.i-7"></a>#endif
<a name="numpy.i-8"></a>#include "stdio.h"
<a name="numpy.i-9"></a>#define NPY_NO_DEPRECATED_API NPY_1_7_API_VERSION
<a name="numpy.i-10"></a>#include &lt;numpy/arrayobject.h&gt;
<a name="numpy.i-11"></a>%}
<a name="numpy.i-12"></a>
<a name="numpy.i-13"></a>/**********************************************************************/
<a name="numpy.i-14"></a>
<a name="numpy.i-15"></a>%fragment("NumPy_Backward_Compatibility", "header")
<a name="numpy.i-16"></a>{
<a name="numpy.i-17"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-18"></a>%#define NPY_ARRAY_DEFAULT NPY_DEFAULT
<a name="numpy.i-19"></a>%#define NPY_ARRAY_FARRAY  NPY_FARRAY
<a name="numpy.i-20"></a>%#define NPY_FORTRANORDER  NPY_FORTRAN
<a name="numpy.i-21"></a>%#endif
<a name="numpy.i-22"></a>}
<a name="numpy.i-23"></a>
<a name="numpy.i-24"></a>/**********************************************************************/
<a name="numpy.i-25"></a>
<a name="numpy.i-26"></a>/* The following code originally appeared in
<a name="numpy.i-27"></a> * enthought/kiva/agg/src/numeric.i written by Eric Jones.  It was
<a name="numpy.i-28"></a> * translated from C++ to C by John Hunter.  Bill Spotz has modified
<a name="numpy.i-29"></a> * it to fix some minor bugs, upgrade from Numeric to numpy (all
<a name="numpy.i-30"></a> * versions), add some comments and functionality, and convert from
<a name="numpy.i-31"></a> * direct code insertion to SWIG fragments.
<a name="numpy.i-32"></a> */
<a name="numpy.i-33"></a>
<a name="numpy.i-34"></a>%fragment("NumPy_Macros", "header")
<a name="numpy.i-35"></a>{
<a name="numpy.i-36"></a>/* Macros to extract array attributes.
<a name="numpy.i-37"></a> */
<a name="numpy.i-38"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-39"></a>%#define is_array(a)            ((a) &amp;&amp; PyArray_Check((PyArrayObject*)a))
<a name="numpy.i-40"></a>%#define array_type(a)          (int)(PyArray_TYPE((PyArrayObject*)a))
<a name="numpy.i-41"></a>%#define array_numdims(a)       (((PyArrayObject*)a)-&gt;nd)
<a name="numpy.i-42"></a>%#define array_dimensions(a)    (((PyArrayObject*)a)-&gt;dimensions)
<a name="numpy.i-43"></a>%#define array_size(a,i)        (((PyArrayObject*)a)-&gt;dimensions[i])
<a name="numpy.i-44"></a>%#define array_strides(a)       (((PyArrayObject*)a)-&gt;strides)
<a name="numpy.i-45"></a>%#define array_stride(a,i)      (((PyArrayObject*)a)-&gt;strides[i])
<a name="numpy.i-46"></a>%#define array_data(a)          (((PyArrayObject*)a)-&gt;data)
<a name="numpy.i-47"></a>%#define array_descr(a)         (((PyArrayObject*)a)-&gt;descr)
<a name="numpy.i-48"></a>%#define array_flags(a)         (((PyArrayObject*)a)-&gt;flags)
<a name="numpy.i-49"></a>%#define array_enableflags(a,f) (((PyArrayObject*)a)-&gt;flags) = f
<a name="numpy.i-50"></a>%#else
<a name="numpy.i-51"></a>%#define is_array(a)            ((a) &amp;&amp; PyArray_Check(a))
<a name="numpy.i-52"></a>%#define array_type(a)          PyArray_TYPE((PyArrayObject*)a)
<a name="numpy.i-53"></a>%#define array_numdims(a)       PyArray_NDIM((PyArrayObject*)a)
<a name="numpy.i-54"></a>%#define array_dimensions(a)    PyArray_DIMS((PyArrayObject*)a)
<a name="numpy.i-55"></a>%#define array_strides(a)       PyArray_STRIDES((PyArrayObject*)a)
<a name="numpy.i-56"></a>%#define array_stride(a,i)      PyArray_STRIDE((PyArrayObject*)a,i)
<a name="numpy.i-57"></a>%#define array_size(a,i)        PyArray_DIM((PyArrayObject*)a,i)
<a name="numpy.i-58"></a>%#define array_data(a)          PyArray_DATA((PyArrayObject*)a)
<a name="numpy.i-59"></a>%#define array_descr(a)         PyArray_DESCR((PyArrayObject*)a)
<a name="numpy.i-60"></a>%#define array_flags(a)         PyArray_FLAGS((PyArrayObject*)a)
<a name="numpy.i-61"></a>%#define array_enableflags(a,f) PyArray_ENABLEFLAGS((PyArrayObject*)a,f)
<a name="numpy.i-62"></a>%#endif
<a name="numpy.i-63"></a>%#define array_is_contiguous(a) (PyArray_ISCONTIGUOUS((PyArrayObject*)a))
<a name="numpy.i-64"></a>%#define array_is_native(a)     (PyArray_ISNOTSWAPPED((PyArrayObject*)a))
<a name="numpy.i-65"></a>%#define array_is_fortran(a)    (PyArray_ISFORTRAN((PyArrayObject*)a))
<a name="numpy.i-66"></a>}
<a name="numpy.i-67"></a>
<a name="numpy.i-68"></a>/**********************************************************************/
<a name="numpy.i-69"></a>
<a name="numpy.i-70"></a>%fragment("NumPy_Utilities",
<a name="numpy.i-71"></a>          "header")
<a name="numpy.i-72"></a>{
<a name="numpy.i-73"></a>  /* Given a PyObject, return a string describing its type.
<a name="numpy.i-74"></a>   */
<a name="numpy.i-75"></a>  const char* pytype_string(PyObject* py_obj)
<a name="numpy.i-76"></a>  {
<a name="numpy.i-77"></a>    if (py_obj == NULL          ) return "C NULL value";
<a name="numpy.i-78"></a>    if (py_obj == Py_None       ) return "Python None" ;
<a name="numpy.i-79"></a>    if (PyCallable_Check(py_obj)) return "callable"    ;
<a name="numpy.i-80"></a>    if (PyString_Check(  py_obj)) return "string"      ;
<a name="numpy.i-81"></a>    if (PyInt_Check(     py_obj)) return "int"         ;
<a name="numpy.i-82"></a>    if (PyFloat_Check(   py_obj)) return "float"       ;
<a name="numpy.i-83"></a>    if (PyDict_Check(    py_obj)) return "dict"        ;
<a name="numpy.i-84"></a>    if (PyList_Check(    py_obj)) return "list"        ;
<a name="numpy.i-85"></a>    if (PyTuple_Check(   py_obj)) return "tuple"       ;
<a name="numpy.i-86"></a>%#if PY_MAJOR_VERSION &lt; 3
<a name="numpy.i-87"></a>    if (PyFile_Check(    py_obj)) return "file"        ;
<a name="numpy.i-88"></a>    if (PyModule_Check(  py_obj)) return "module"      ;
<a name="numpy.i-89"></a>    if (PyInstance_Check(py_obj)) return "instance"    ;
<a name="numpy.i-90"></a>%#endif
<a name="numpy.i-91"></a>
<a name="numpy.i-92"></a>    return "unkown type";
<a name="numpy.i-93"></a>  }
<a name="numpy.i-94"></a>
<a name="numpy.i-95"></a>  /* Given a NumPy typecode, return a string describing the type.
<a name="numpy.i-96"></a>   */
<a name="numpy.i-97"></a>  const char* typecode_string(int typecode)
<a name="numpy.i-98"></a>  {
<a name="numpy.i-99"></a>    static const char* type_names[25] = {"bool",
<a name="numpy.i-100"></a>                                         "byte",
<a name="numpy.i-101"></a>                                         "unsigned byte",
<a name="numpy.i-102"></a>                                         "short",
<a name="numpy.i-103"></a>                                         "unsigned short",
<a name="numpy.i-104"></a>                                         "int",
<a name="numpy.i-105"></a>                                         "unsigned int",
<a name="numpy.i-106"></a>                                         "long",
<a name="numpy.i-107"></a>                                         "unsigned long",
<a name="numpy.i-108"></a>                                         "long long",
<a name="numpy.i-109"></a>                                         "unsigned long long",
<a name="numpy.i-110"></a>                                         "float",
<a name="numpy.i-111"></a>                                         "double",
<a name="numpy.i-112"></a>                                         "long double",
<a name="numpy.i-113"></a>                                         "complex float",
<a name="numpy.i-114"></a>                                         "complex double",
<a name="numpy.i-115"></a>                                         "complex long double",
<a name="numpy.i-116"></a>                                         "object",
<a name="numpy.i-117"></a>                                         "string",
<a name="numpy.i-118"></a>                                         "unicode",
<a name="numpy.i-119"></a>                                         "void",
<a name="numpy.i-120"></a>                                         "ntypes",
<a name="numpy.i-121"></a>                                         "notype",
<a name="numpy.i-122"></a>                                         "char",
<a name="numpy.i-123"></a>                                         "unknown"};
<a name="numpy.i-124"></a>    return typecode &lt; 24 ? type_names[typecode] : type_names[24];
<a name="numpy.i-125"></a>  }
<a name="numpy.i-126"></a>
<a name="numpy.i-127"></a>  /* Make sure input has correct numpy type.  This now just calls
<a name="numpy.i-128"></a>     PyArray_EquivTypenums().
<a name="numpy.i-129"></a>   */
<a name="numpy.i-130"></a>  int type_match(int actual_type,
<a name="numpy.i-131"></a>                 int desired_type)
<a name="numpy.i-132"></a>  {
<a name="numpy.i-133"></a>    return PyArray_EquivTypenums(actual_type, desired_type);
<a name="numpy.i-134"></a>  }
<a name="numpy.i-135"></a>
<a name="numpy.i-136"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-137"></a>  void free_cap(PyObject * cap)
<a name="numpy.i-138"></a>  {
<a name="numpy.i-139"></a>    void* array = (void*) PyCapsule_GetPointer(cap,SWIGPY_CAPSULE_NAME);
<a name="numpy.i-140"></a>    if (array != NULL) free(array);
<a name="numpy.i-141"></a>  }
<a name="numpy.i-142"></a>%#endif
<a name="numpy.i-143"></a>
<a name="numpy.i-144"></a>
<a name="numpy.i-145"></a>}
<a name="numpy.i-146"></a>
<a name="numpy.i-147"></a>/**********************************************************************/
<a name="numpy.i-148"></a>
<a name="numpy.i-149"></a>%fragment("NumPy_Object_to_Array",
<a name="numpy.i-150"></a>          "header",
<a name="numpy.i-151"></a>          fragment="NumPy_Backward_Compatibility",
<a name="numpy.i-152"></a>          fragment="NumPy_Macros",
<a name="numpy.i-153"></a>          fragment="NumPy_Utilities")
<a name="numpy.i-154"></a>{
<a name="numpy.i-155"></a>  /* Given a PyObject pointer, cast it to a PyArrayObject pointer if
<a name="numpy.i-156"></a>   * legal.  If not, set the python error string appropriately and
<a name="numpy.i-157"></a>   * return NULL.
<a name="numpy.i-158"></a>   */
<a name="numpy.i-159"></a>  PyArrayObject* obj_to_array_no_conversion(PyObject* input,
<a name="numpy.i-160"></a>                                            int        typecode)
<a name="numpy.i-161"></a>  {
<a name="numpy.i-162"></a>    PyArrayObject* ary = NULL;
<a name="numpy.i-163"></a>    if (is_array(input) &amp;&amp; (typecode == NPY_NOTYPE ||
<a name="numpy.i-164"></a>                            PyArray_EquivTypenums(array_type(input), typecode)))
<a name="numpy.i-165"></a>    {
<a name="numpy.i-166"></a>      ary = (PyArrayObject*) input;
<a name="numpy.i-167"></a>    }
<a name="numpy.i-168"></a>    else if is_array(input)
<a name="numpy.i-169"></a>    {
<a name="numpy.i-170"></a>      const char* desired_type = typecode_string(typecode);
<a name="numpy.i-171"></a>      const char* actual_type  = typecode_string(array_type(input));
<a name="numpy.i-172"></a>      PyErr_Format(PyExc_TypeError,
<a name="numpy.i-173"></a>                   "Array of type '%s' required.  Array of type '%s' given",
<a name="numpy.i-174"></a>                   desired_type, actual_type);
<a name="numpy.i-175"></a>      ary = NULL;
<a name="numpy.i-176"></a>    }
<a name="numpy.i-177"></a>    else
<a name="numpy.i-178"></a>    {
<a name="numpy.i-179"></a>      const char* desired_type = typecode_string(typecode);
<a name="numpy.i-180"></a>      const char* actual_type  = pytype_string(input);
<a name="numpy.i-181"></a>      PyErr_Format(PyExc_TypeError,
<a name="numpy.i-182"></a>                   "Array of type '%s' required.  A '%s' was given",
<a name="numpy.i-183"></a>                   desired_type,
<a name="numpy.i-184"></a>                   actual_type);
<a name="numpy.i-185"></a>      ary = NULL;
<a name="numpy.i-186"></a>    }
<a name="numpy.i-187"></a>    return ary;
<a name="numpy.i-188"></a>  }
<a name="numpy.i-189"></a>
<a name="numpy.i-190"></a>  /* Convert the given PyObject to a NumPy array with the given
<a name="numpy.i-191"></a>   * typecode.  On success, return a valid PyArrayObject* with the
<a name="numpy.i-192"></a>   * correct type.  On failure, the python error string will be set and
<a name="numpy.i-193"></a>   * the routine returns NULL.
<a name="numpy.i-194"></a>   */
<a name="numpy.i-195"></a>  PyArrayObject* obj_to_array_allow_conversion(PyObject* input,
<a name="numpy.i-196"></a>                                               int       typecode,
<a name="numpy.i-197"></a>                                               int*      is_new_object)
<a name="numpy.i-198"></a>  {
<a name="numpy.i-199"></a>    PyArrayObject* ary = NULL;
<a name="numpy.i-200"></a>    PyObject*      py_obj;
<a name="numpy.i-201"></a>    if (is_array(input) &amp;&amp; (typecode == NPY_NOTYPE ||
<a name="numpy.i-202"></a>                            PyArray_EquivTypenums(array_type(input),typecode)))
<a name="numpy.i-203"></a>    {
<a name="numpy.i-204"></a>      ary = (PyArrayObject*) input;
<a name="numpy.i-205"></a>      *is_new_object = 0;
<a name="numpy.i-206"></a>    }
<a name="numpy.i-207"></a>    else
<a name="numpy.i-208"></a>    {
<a name="numpy.i-209"></a>      py_obj = PyArray_FROMANY(input, typecode, 0, 0, NPY_ARRAY_DEFAULT);
<a name="numpy.i-210"></a>      /* If NULL, PyArray_FromObject will have set python error value.*/
<a name="numpy.i-211"></a>      ary = (PyArrayObject*) py_obj;
<a name="numpy.i-212"></a>      *is_new_object = 1;
<a name="numpy.i-213"></a>    }
<a name="numpy.i-214"></a>    return ary;
<a name="numpy.i-215"></a>  }
<a name="numpy.i-216"></a>
<a name="numpy.i-217"></a>  /* Given a PyArrayObject, check to see if it is contiguous.  If so,
<a name="numpy.i-218"></a>   * return the input pointer and flag it as not a new object.  If it is
<a name="numpy.i-219"></a>   * not contiguous, create a new PyArrayObject using the original data,
<a name="numpy.i-220"></a>   * flag it as a new object and return the pointer.
<a name="numpy.i-221"></a>   */
<a name="numpy.i-222"></a>  PyArrayObject* make_contiguous(PyArrayObject* ary,
<a name="numpy.i-223"></a>                                 int*           is_new_object,
<a name="numpy.i-224"></a>                                 int            min_dims,
<a name="numpy.i-225"></a>                                 int            max_dims)
<a name="numpy.i-226"></a>  {
<a name="numpy.i-227"></a>    PyArrayObject* result;
<a name="numpy.i-228"></a>    if (array_is_contiguous(ary))
<a name="numpy.i-229"></a>    {
<a name="numpy.i-230"></a>      result = ary;
<a name="numpy.i-231"></a>      *is_new_object = 0;
<a name="numpy.i-232"></a>    }
<a name="numpy.i-233"></a>    else
<a name="numpy.i-234"></a>    {
<a name="numpy.i-235"></a>      result = (PyArrayObject*) PyArray_ContiguousFromObject((PyObject*)ary,
<a name="numpy.i-236"></a>                                                              array_type(ary),
<a name="numpy.i-237"></a>                                                              min_dims,
<a name="numpy.i-238"></a>                                                              max_dims);
<a name="numpy.i-239"></a>      *is_new_object = 1;
<a name="numpy.i-240"></a>    }
<a name="numpy.i-241"></a>    return result;
<a name="numpy.i-242"></a>  }
<a name="numpy.i-243"></a>
<a name="numpy.i-244"></a>  /* Given a PyArrayObject, check to see if it is Fortran-contiguous.
<a name="numpy.i-245"></a>   * If so, return the input pointer, but do not flag it as not a new
<a name="numpy.i-246"></a>   * object.  If it is not Fortran-contiguous, create a new
<a name="numpy.i-247"></a>   * PyArrayObject using the original data, flag it as a new object
<a name="numpy.i-248"></a>   * and return the pointer.
<a name="numpy.i-249"></a>   */
<a name="numpy.i-250"></a>  PyArrayObject* make_fortran(PyArrayObject* ary,
<a name="numpy.i-251"></a>                              int*           is_new_object)
<a name="numpy.i-252"></a>  {
<a name="numpy.i-253"></a>    PyArrayObject* result;
<a name="numpy.i-254"></a>    if (array_is_fortran(ary))
<a name="numpy.i-255"></a>    {
<a name="numpy.i-256"></a>      result = ary;
<a name="numpy.i-257"></a>      *is_new_object = 0;
<a name="numpy.i-258"></a>    }
<a name="numpy.i-259"></a>    else
<a name="numpy.i-260"></a>    {
<a name="numpy.i-261"></a>      Py_INCREF(array_descr(ary));
<a name="numpy.i-262"></a>      result = (PyArrayObject*) PyArray_FromArray(ary,
<a name="numpy.i-263"></a>                                                  array_descr(ary),
<a name="numpy.i-264"></a>                                                  NPY_FORTRANORDER);
<a name="numpy.i-265"></a>      *is_new_object = 1;
<a name="numpy.i-266"></a>    }
<a name="numpy.i-267"></a>    return result;
<a name="numpy.i-268"></a>  }
<a name="numpy.i-269"></a>
<a name="numpy.i-270"></a>  /* Convert a given PyObject to a contiguous PyArrayObject of the
<a name="numpy.i-271"></a>   * specified type.  If the input object is not a contiguous
<a name="numpy.i-272"></a>   * PyArrayObject, a new one will be created and the new object flag
<a name="numpy.i-273"></a>   * will be set.
<a name="numpy.i-274"></a>   */
<a name="numpy.i-275"></a>  PyArrayObject* obj_to_array_contiguous_allow_conversion(PyObject* input,
<a name="numpy.i-276"></a>                                                          int       typecode,
<a name="numpy.i-277"></a>                                                          int*      is_new_object)
<a name="numpy.i-278"></a>  {
<a name="numpy.i-279"></a>    int is_new1 = 0;
<a name="numpy.i-280"></a>    int is_new2 = 0;
<a name="numpy.i-281"></a>    PyArrayObject* ary2;
<a name="numpy.i-282"></a>    PyArrayObject* ary1 = obj_to_array_allow_conversion(input,
<a name="numpy.i-283"></a>                                                        typecode,
<a name="numpy.i-284"></a>                                                        &amp;is_new1);
<a name="numpy.i-285"></a>    if (ary1)
<a name="numpy.i-286"></a>    {
<a name="numpy.i-287"></a>      ary2 = make_contiguous(ary1, &amp;is_new2, 0, 0);
<a name="numpy.i-288"></a>      if ( is_new1 &amp;&amp; is_new2)
<a name="numpy.i-289"></a>      {
<a name="numpy.i-290"></a>        Py_DECREF(ary1);
<a name="numpy.i-291"></a>      }
<a name="numpy.i-292"></a>      ary1 = ary2;
<a name="numpy.i-293"></a>    }
<a name="numpy.i-294"></a>    *is_new_object = is_new1 || is_new2;
<a name="numpy.i-295"></a>    return ary1;
<a name="numpy.i-296"></a>  }
<a name="numpy.i-297"></a>
<a name="numpy.i-298"></a>  /* Convert a given PyObject to a Fortran-ordered PyArrayObject of the
<a name="numpy.i-299"></a>   * specified type.  If the input object is not a Fortran-ordered
<a name="numpy.i-300"></a>   * PyArrayObject, a new one will be created and the new object flag
<a name="numpy.i-301"></a>   * will be set.
<a name="numpy.i-302"></a>   */
<a name="numpy.i-303"></a>  PyArrayObject* obj_to_array_fortran_allow_conversion(PyObject* input,
<a name="numpy.i-304"></a>                                                       int       typecode,
<a name="numpy.i-305"></a>                                                       int*      is_new_object)
<a name="numpy.i-306"></a>  {
<a name="numpy.i-307"></a>    int is_new1 = 0;
<a name="numpy.i-308"></a>    int is_new2 = 0;
<a name="numpy.i-309"></a>    PyArrayObject* ary2;
<a name="numpy.i-310"></a>    PyArrayObject* ary1 = obj_to_array_allow_conversion(input,
<a name="numpy.i-311"></a>                                                        typecode,
<a name="numpy.i-312"></a>                                                        &amp;is_new1);
<a name="numpy.i-313"></a>    if (ary1)
<a name="numpy.i-314"></a>    {
<a name="numpy.i-315"></a>      ary2 = make_fortran(ary1, &amp;is_new2);
<a name="numpy.i-316"></a>      if (is_new1 &amp;&amp; is_new2)
<a name="numpy.i-317"></a>      {
<a name="numpy.i-318"></a>        Py_DECREF(ary1);
<a name="numpy.i-319"></a>      }
<a name="numpy.i-320"></a>      ary1 = ary2;
<a name="numpy.i-321"></a>    }
<a name="numpy.i-322"></a>    *is_new_object = is_new1 || is_new2;
<a name="numpy.i-323"></a>    return ary1;
<a name="numpy.i-324"></a>  }
<a name="numpy.i-325"></a>} /* end fragment */
<a name="numpy.i-326"></a>
<a name="numpy.i-327"></a>/**********************************************************************/
<a name="numpy.i-328"></a>
<a name="numpy.i-329"></a>%fragment("NumPy_Array_Requirements",
<a name="numpy.i-330"></a>          "header",
<a name="numpy.i-331"></a>          fragment="NumPy_Backward_Compatibility",
<a name="numpy.i-332"></a>          fragment="NumPy_Macros")
<a name="numpy.i-333"></a>{
<a name="numpy.i-334"></a>  /* Test whether a python object is contiguous.  If array is
<a name="numpy.i-335"></a>   * contiguous, return 1.  Otherwise, set the python error string and
<a name="numpy.i-336"></a>   * return 0.
<a name="numpy.i-337"></a>   */
<a name="numpy.i-338"></a>  int require_contiguous(PyArrayObject* ary)
<a name="numpy.i-339"></a>  {
<a name="numpy.i-340"></a>    int contiguous = 1;
<a name="numpy.i-341"></a>    if (!array_is_contiguous(ary))
<a name="numpy.i-342"></a>    {
<a name="numpy.i-343"></a>      PyErr_SetString(PyExc_TypeError,
<a name="numpy.i-344"></a>                      "Array must be contiguous.  A non-contiguous array was given");
<a name="numpy.i-345"></a>      contiguous = 0;
<a name="numpy.i-346"></a>    }
<a name="numpy.i-347"></a>    return contiguous;
<a name="numpy.i-348"></a>  }
<a name="numpy.i-349"></a>
<a name="numpy.i-350"></a>  /* Require that a numpy array is not byte-swapped.  If the array is
<a name="numpy.i-351"></a>   * not byte-swapped, return 1.  Otherwise, set the python error string
<a name="numpy.i-352"></a>   * and return 0.
<a name="numpy.i-353"></a>   */
<a name="numpy.i-354"></a>  int require_native(PyArrayObject* ary)
<a name="numpy.i-355"></a>  {
<a name="numpy.i-356"></a>    int native = 1;
<a name="numpy.i-357"></a>    if (!array_is_native(ary))
<a name="numpy.i-358"></a>    {
<a name="numpy.i-359"></a>      PyErr_SetString(PyExc_TypeError,
<a name="numpy.i-360"></a>                      "Array must have native byteorder.  "
<a name="numpy.i-361"></a>                      "A byte-swapped array was given");
<a name="numpy.i-362"></a>      native = 0;
<a name="numpy.i-363"></a>    }
<a name="numpy.i-364"></a>    return native;
<a name="numpy.i-365"></a>  }
<a name="numpy.i-366"></a>
<a name="numpy.i-367"></a>  /* Require the given PyArrayObject to have a specified number of
<a name="numpy.i-368"></a>   * dimensions.  If the array has the specified number of dimensions,
<a name="numpy.i-369"></a>   * return 1.  Otherwise, set the python error string and return 0.
<a name="numpy.i-370"></a>   */
<a name="numpy.i-371"></a>  int require_dimensions(PyArrayObject* ary,
<a name="numpy.i-372"></a>                         int            exact_dimensions)
<a name="numpy.i-373"></a>  {
<a name="numpy.i-374"></a>    int success = 1;
<a name="numpy.i-375"></a>    if (array_numdims(ary) != exact_dimensions)
<a name="numpy.i-376"></a>    {
<a name="numpy.i-377"></a>      PyErr_Format(PyExc_TypeError,
<a name="numpy.i-378"></a>                   "Array must have %d dimensions.  Given array has %d dimensions",
<a name="numpy.i-379"></a>                   exact_dimensions,
<a name="numpy.i-380"></a>                   array_numdims(ary));
<a name="numpy.i-381"></a>      success = 0;
<a name="numpy.i-382"></a>    }
<a name="numpy.i-383"></a>    return success;
<a name="numpy.i-384"></a>  }
<a name="numpy.i-385"></a>
<a name="numpy.i-386"></a>  /* Require the given PyArrayObject to have one of a list of specified
<a name="numpy.i-387"></a>   * number of dimensions.  If the array has one of the specified number
<a name="numpy.i-388"></a>   * of dimensions, return 1.  Otherwise, set the python error string
<a name="numpy.i-389"></a>   * and return 0.
<a name="numpy.i-390"></a>   */
<a name="numpy.i-391"></a>  int require_dimensions_n(PyArrayObject* ary,
<a name="numpy.i-392"></a>                           int*           exact_dimensions,
<a name="numpy.i-393"></a>                           int            n)
<a name="numpy.i-394"></a>  {
<a name="numpy.i-395"></a>    int success = 0;
<a name="numpy.i-396"></a>    int i;
<a name="numpy.i-397"></a>    char dims_str[255] = "";
<a name="numpy.i-398"></a>    char s[255];
<a name="numpy.i-399"></a>    for (i = 0; i &lt; n &amp;&amp; !success; i++)
<a name="numpy.i-400"></a>    {
<a name="numpy.i-401"></a>      if (array_numdims(ary) == exact_dimensions[i])
<a name="numpy.i-402"></a>      {
<a name="numpy.i-403"></a>        success = 1;
<a name="numpy.i-404"></a>      }
<a name="numpy.i-405"></a>    }
<a name="numpy.i-406"></a>    if (!success)
<a name="numpy.i-407"></a>    {
<a name="numpy.i-408"></a>      for (i = 0; i &lt; n-1; i++)
<a name="numpy.i-409"></a>      {
<a name="numpy.i-410"></a>        sprintf(s, "%d, ", exact_dimensions[i]);
<a name="numpy.i-411"></a>        strcat(dims_str,s);
<a name="numpy.i-412"></a>      }
<a name="numpy.i-413"></a>      sprintf(s, " or %d", exact_dimensions[n-1]);
<a name="numpy.i-414"></a>      strcat(dims_str,s);
<a name="numpy.i-415"></a>      PyErr_Format(PyExc_TypeError,
<a name="numpy.i-416"></a>                   "Array must have %s dimensions.  Given array has %d dimensions",
<a name="numpy.i-417"></a>                   dims_str,
<a name="numpy.i-418"></a>                   array_numdims(ary));
<a name="numpy.i-419"></a>    }
<a name="numpy.i-420"></a>    return success;
<a name="numpy.i-421"></a>  }
<a name="numpy.i-422"></a>
<a name="numpy.i-423"></a>  /* Require the given PyArrayObject to have a specified shape.  If the
<a name="numpy.i-424"></a>   * array has the specified shape, return 1.  Otherwise, set the python
<a name="numpy.i-425"></a>   * error string and return 0.
<a name="numpy.i-426"></a>   */
<a name="numpy.i-427"></a>  int require_size(PyArrayObject* ary,
<a name="numpy.i-428"></a>                   npy_intp*      size,
<a name="numpy.i-429"></a>                   int            n)
<a name="numpy.i-430"></a>  {
<a name="numpy.i-431"></a>    int i;
<a name="numpy.i-432"></a>    int success = 1;
<a name="numpy.i-433"></a>    int len;
<a name="numpy.i-434"></a>    char desired_dims[255] = "[";
<a name="numpy.i-435"></a>    char s[255];
<a name="numpy.i-436"></a>    char actual_dims[255] = "[";
<a name="numpy.i-437"></a>    for(i=0; i &lt; n;i++)
<a name="numpy.i-438"></a>    {
<a name="numpy.i-439"></a>      if (size[i] != -1 &amp;&amp;  size[i] != array_size(ary,i))
<a name="numpy.i-440"></a>      {
<a name="numpy.i-441"></a>        success = 0;
<a name="numpy.i-442"></a>      }
<a name="numpy.i-443"></a>    }
<a name="numpy.i-444"></a>    if (!success)
<a name="numpy.i-445"></a>    {
<a name="numpy.i-446"></a>      for (i = 0; i &lt; n; i++)
<a name="numpy.i-447"></a>      {
<a name="numpy.i-448"></a>        if (size[i] == -1)
<a name="numpy.i-449"></a>        {
<a name="numpy.i-450"></a>          sprintf(s, "*,");
<a name="numpy.i-451"></a>        }
<a name="numpy.i-452"></a>        else
<a name="numpy.i-453"></a>        {
<a name="numpy.i-454"></a>          sprintf(s, "%ld,", (long int)size[i]);
<a name="numpy.i-455"></a>        }
<a name="numpy.i-456"></a>        strcat(desired_dims,s);
<a name="numpy.i-457"></a>      }
<a name="numpy.i-458"></a>      len = strlen(desired_dims);
<a name="numpy.i-459"></a>      desired_dims[len-1] = ']';
<a name="numpy.i-460"></a>      for (i = 0; i &lt; n; i++)
<a name="numpy.i-461"></a>      {
<a name="numpy.i-462"></a>        sprintf(s, "%ld,", (long int)array_size(ary,i));
<a name="numpy.i-463"></a>        strcat(actual_dims,s);
<a name="numpy.i-464"></a>      }
<a name="numpy.i-465"></a>      len = strlen(actual_dims);
<a name="numpy.i-466"></a>      actual_dims[len-1] = ']';
<a name="numpy.i-467"></a>      PyErr_Format(PyExc_TypeError,
<a name="numpy.i-468"></a>                   "Array must have shape of %s.  Given array has shape of %s",
<a name="numpy.i-469"></a>                   desired_dims,
<a name="numpy.i-470"></a>                   actual_dims);
<a name="numpy.i-471"></a>    }
<a name="numpy.i-472"></a>    return success;
<a name="numpy.i-473"></a>  }
<a name="numpy.i-474"></a>
<a name="numpy.i-475"></a>  /* Require the given PyArrayObject to to be Fortran ordered.  If the
<a name="numpy.i-476"></a>   * the PyArrayObject is already Fortran ordered, do nothing.  Else,
<a name="numpy.i-477"></a>   * set the Fortran ordering flag and recompute the strides.
<a name="numpy.i-478"></a>   */
<a name="numpy.i-479"></a>  int require_fortran(PyArrayObject* ary)
<a name="numpy.i-480"></a>  {
<a name="numpy.i-481"></a>    int success = 1;
<a name="numpy.i-482"></a>    int nd = array_numdims(ary);
<a name="numpy.i-483"></a>    int i;
<a name="numpy.i-484"></a>    npy_intp * strides = array_strides(ary);
<a name="numpy.i-485"></a>    if (array_is_fortran(ary)) return success;
<a name="numpy.i-486"></a>    /* Set the Fortran ordered flag */
<a name="numpy.i-487"></a>    array_enableflags(ary,NPY_ARRAY_FARRAY);
<a name="numpy.i-488"></a>    /* Recompute the strides */
<a name="numpy.i-489"></a>    strides[0] = strides[nd-1];
<a name="numpy.i-490"></a>    for (i=1; i &lt; nd; ++i)
<a name="numpy.i-491"></a>      strides[i] = strides[i-1] * array_size(ary,i-1);
<a name="numpy.i-492"></a>    return success;
<a name="numpy.i-493"></a>  }
<a name="numpy.i-494"></a>}
<a name="numpy.i-495"></a>
<a name="numpy.i-496"></a>/* Combine all NumPy fragments into one for convenience */
<a name="numpy.i-497"></a>%fragment("NumPy_Fragments",
<a name="numpy.i-498"></a>          "header",
<a name="numpy.i-499"></a>          fragment="NumPy_Backward_Compatibility",
<a name="numpy.i-500"></a>          fragment="NumPy_Macros",
<a name="numpy.i-501"></a>          fragment="NumPy_Utilities",
<a name="numpy.i-502"></a>          fragment="NumPy_Object_to_Array",
<a name="numpy.i-503"></a>          fragment="NumPy_Array_Requirements")
<a name="numpy.i-504"></a>{
<a name="numpy.i-505"></a>}
<a name="numpy.i-506"></a>
<a name="numpy.i-507"></a>/* End John Hunter translation (with modifications by Bill Spotz)
<a name="numpy.i-508"></a> */
<a name="numpy.i-509"></a>
<a name="numpy.i-510"></a>/* %numpy_typemaps() macro
<a name="numpy.i-511"></a> *
<a name="numpy.i-512"></a> * This macro defines a family of 74 typemaps that allow C arguments
<a name="numpy.i-513"></a> * of the form
<a name="numpy.i-514"></a> *
<a name="numpy.i-515"></a> *    1. (DATA_TYPE IN_ARRAY1[ANY])
<a name="numpy.i-516"></a> *    2. (DATA_TYPE* IN_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-517"></a> *    3. (DIM_TYPE DIM1, DATA_TYPE* IN_ARRAY1)
<a name="numpy.i-518"></a> *
<a name="numpy.i-519"></a> *    4. (DATA_TYPE IN_ARRAY2[ANY][ANY])
<a name="numpy.i-520"></a> *    5. (DATA_TYPE* IN_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-521"></a> *    6. (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_ARRAY2)
<a name="numpy.i-522"></a> *    7. (DATA_TYPE* IN_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-523"></a> *    8. (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_FARRAY2)
<a name="numpy.i-524"></a> *
<a name="numpy.i-525"></a> *    9. (DATA_TYPE IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-526"></a> *   10. (DATA_TYPE* IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-527"></a> *   11. (DATA_TYPE** IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-528"></a> *   12. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_ARRAY3)
<a name="numpy.i-529"></a> *   13. (DATA_TYPE* IN_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-530"></a> *   14. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_FARRAY3)
<a name="numpy.i-531"></a> *
<a name="numpy.i-532"></a> *   15. (DATA_TYPE IN_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-533"></a> *   16. (DATA_TYPE* IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-534"></a> *   17. (DATA_TYPE** IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-535"></a> *   18. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, , DIM_TYPE DIM4, DATA_TYPE* IN_ARRAY4)
<a name="numpy.i-536"></a> *   19. (DATA_TYPE* IN_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-537"></a> *   20. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_FARRAY4)
<a name="numpy.i-538"></a> *
<a name="numpy.i-539"></a> *   21. (DATA_TYPE INPLACE_ARRAY1[ANY])
<a name="numpy.i-540"></a> *   22. (DATA_TYPE* INPLACE_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-541"></a> *   23. (DIM_TYPE DIM1, DATA_TYPE* INPLACE_ARRAY1)
<a name="numpy.i-542"></a> *
<a name="numpy.i-543"></a> *   24. (DATA_TYPE INPLACE_ARRAY2[ANY][ANY])
<a name="numpy.i-544"></a> *   25. (DATA_TYPE* INPLACE_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-545"></a> *   26. (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_ARRAY2)
<a name="numpy.i-546"></a> *   27. (DATA_TYPE* INPLACE_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-547"></a> *   28. (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_FARRAY2)
<a name="numpy.i-548"></a> *
<a name="numpy.i-549"></a> *   29. (DATA_TYPE INPLACE_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-550"></a> *   30. (DATA_TYPE* INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-551"></a> *   31. (DATA_TYPE** INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-552"></a> *   32. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_ARRAY3)
<a name="numpy.i-553"></a> *   33. (DATA_TYPE* INPLACE_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-554"></a> *   34. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_FARRAY3)
<a name="numpy.i-555"></a> *
<a name="numpy.i-556"></a> *   35. (DATA_TYPE INPLACE_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-557"></a> *   36. (DATA_TYPE* INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-558"></a> *   37. (DATA_TYPE** INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-559"></a> *   38. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_ARRAY4)
<a name="numpy.i-560"></a> *   39. (DATA_TYPE* INPLACE_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-561"></a> *   40. (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_FARRAY4)
<a name="numpy.i-562"></a> *
<a name="numpy.i-563"></a> *   41. (DATA_TYPE ARGOUT_ARRAY1[ANY])
<a name="numpy.i-564"></a> *   42. (DATA_TYPE* ARGOUT_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-565"></a> *   43. (DIM_TYPE DIM1, DATA_TYPE* ARGOUT_ARRAY1)
<a name="numpy.i-566"></a> *
<a name="numpy.i-567"></a> *   44. (DATA_TYPE ARGOUT_ARRAY2[ANY][ANY])
<a name="numpy.i-568"></a> *
<a name="numpy.i-569"></a> *   45. (DATA_TYPE ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-570"></a> *
<a name="numpy.i-571"></a> *   46. (DATA_TYPE ARGOUT_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-572"></a> *
<a name="numpy.i-573"></a> *   47. (DATA_TYPE** ARGOUTVIEW_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-574"></a> *   48. (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEW_ARRAY1)
<a name="numpy.i-575"></a> *
<a name="numpy.i-576"></a> *   49. (DATA_TYPE** ARGOUTVIEW_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-577"></a> *   50. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_ARRAY2)
<a name="numpy.i-578"></a> *   51. (DATA_TYPE** ARGOUTVIEW_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-579"></a> *   52. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_FARRAY2)
<a name="numpy.i-580"></a> *
<a name="numpy.i-581"></a> *   53. (DATA_TYPE** ARGOUTVIEW_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-582"></a> *   54. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEW_ARRAY3)
<a name="numpy.i-583"></a> *   55. (DATA_TYPE** ARGOUTVIEW_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-584"></a> *   56. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEW_FARRAY3)
<a name="numpy.i-585"></a> *
<a name="numpy.i-586"></a> *   57. (DATA_TYPE** ARGOUTVIEW_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-587"></a> *   58. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEW_ARRAY4)
<a name="numpy.i-588"></a> *   59. (DATA_TYPE** ARGOUTVIEW_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-589"></a> *   60. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEW_FARRAY4)
<a name="numpy.i-590"></a> *
<a name="numpy.i-591"></a> *   61. (DATA_TYPE** ARGOUTVIEWM_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-592"></a> *   62. (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEWM_ARRAY1)
<a name="numpy.i-593"></a> *
<a name="numpy.i-594"></a> *   63. (DATA_TYPE** ARGOUTVIEWM_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-595"></a> *   64. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_ARRAY2)
<a name="numpy.i-596"></a> *   65. (DATA_TYPE** ARGOUTVIEWM_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-597"></a> *   66. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_FARRAY2)
<a name="numpy.i-598"></a> *
<a name="numpy.i-599"></a> *   67. (DATA_TYPE** ARGOUTVIEWM_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-600"></a> *   68. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEWM_ARRAY3)
<a name="numpy.i-601"></a> *   69. (DATA_TYPE** ARGOUTVIEWM_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-602"></a> *   70. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEWM_FARRAY3)
<a name="numpy.i-603"></a> *
<a name="numpy.i-604"></a> *   71. (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-605"></a> *   72. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-606"></a> *   73. (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-607"></a> *   74. (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-608"></a> *
<a name="numpy.i-609"></a> * where "DATA_TYPE" is any type supported by the NumPy module, and
<a name="numpy.i-610"></a> * "DIM_TYPE" is any int-like type suitable for specifying dimensions.
<a name="numpy.i-611"></a> * The difference between "ARRAY" typemaps and "FARRAY" typemaps is
<a name="numpy.i-612"></a> * that the "FARRAY" typemaps expect Fortran ordering of
<a name="numpy.i-613"></a> * multidimensional arrays.  In python, the dimensions will not need
<a name="numpy.i-614"></a> * to be specified (except for the "DATA_TYPE* ARGOUT_ARRAY1"
<a name="numpy.i-615"></a> * typemaps).  The IN_ARRAYs can be a numpy array or any sequence that
<a name="numpy.i-616"></a> * can be converted to a numpy array of the specified type.  The
<a name="numpy.i-617"></a> * INPLACE_ARRAYs must be numpy arrays of the appropriate type.  The
<a name="numpy.i-618"></a> * ARGOUT_ARRAYs will be returned as new numpy arrays of the
<a name="numpy.i-619"></a> * appropriate type.
<a name="numpy.i-620"></a> *
<a name="numpy.i-621"></a> * These typemaps can be applied to existing functions using the
<a name="numpy.i-622"></a> * %apply directive.  For example:
<a name="numpy.i-623"></a> *
<a name="numpy.i-624"></a> *     %apply (double* IN_ARRAY1, int DIM1) {(double* series, int length)};
<a name="numpy.i-625"></a> *     double prod(double* series, int length);
<a name="numpy.i-626"></a> *
<a name="numpy.i-627"></a> *     %apply (int DIM1, int DIM2, double* INPLACE_ARRAY2)
<a name="numpy.i-628"></a> *           {(int rows, int cols, double* matrix        )};
<a name="numpy.i-629"></a> *     void floor(int rows, int cols, double* matrix, double f);
<a name="numpy.i-630"></a> *
<a name="numpy.i-631"></a> *     %apply (double IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-632"></a> *           {(double tensor[2][2][2]         )};
<a name="numpy.i-633"></a> *     %apply (double ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-634"></a> *           {(double low[2][2][2]                )};
<a name="numpy.i-635"></a> *     %apply (double ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-636"></a> *           {(double upp[2][2][2]                )};
<a name="numpy.i-637"></a> *     void luSplit(double tensor[2][2][2],
<a name="numpy.i-638"></a> *                  double low[2][2][2],
<a name="numpy.i-639"></a> *                  double upp[2][2][2]    );
<a name="numpy.i-640"></a> *
<a name="numpy.i-641"></a> * or directly with
<a name="numpy.i-642"></a> *
<a name="numpy.i-643"></a> *     double prod(double* IN_ARRAY1, int DIM1);
<a name="numpy.i-644"></a> *
<a name="numpy.i-645"></a> *     void floor(int DIM1, int DIM2, double* INPLACE_ARRAY2, double f);
<a name="numpy.i-646"></a> *
<a name="numpy.i-647"></a> *     void luSplit(double IN_ARRAY3[ANY][ANY][ANY],
<a name="numpy.i-648"></a> *                  double ARGOUT_ARRAY3[ANY][ANY][ANY],
<a name="numpy.i-649"></a> *                  double ARGOUT_ARRAY3[ANY][ANY][ANY]);
<a name="numpy.i-650"></a> */
<a name="numpy.i-651"></a>
<a name="numpy.i-652"></a>%define %numpy_typemaps(DATA_TYPE, DATA_TYPECODE, DIM_TYPE)
<a name="numpy.i-653"></a>
<a name="numpy.i-654"></a>/************************/
<a name="numpy.i-655"></a>/* Input Array Typemaps */
<a name="numpy.i-656"></a>/************************/
<a name="numpy.i-657"></a>
<a name="numpy.i-658"></a>/* Typemap suite for (DATA_TYPE IN_ARRAY1[ANY])
<a name="numpy.i-659"></a> */
<a name="numpy.i-660"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-661"></a>           fragment="NumPy_Macros")
<a name="numpy.i-662"></a>  (DATA_TYPE IN_ARRAY1[ANY])
<a name="numpy.i-663"></a>{
<a name="numpy.i-664"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-665"></a>}
<a name="numpy.i-666"></a>%typemap(in,
<a name="numpy.i-667"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-668"></a>  (DATA_TYPE IN_ARRAY1[ANY])
<a name="numpy.i-669"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-670"></a>{
<a name="numpy.i-671"></a>  npy_intp size[1] = { $1_dim0 };
<a name="numpy.i-672"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-673"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-674"></a>                                                   &amp;is_new_object);
<a name="numpy.i-675"></a>  if (!array || !require_dimensions(array, 1) ||
<a name="numpy.i-676"></a>      !require_size(array, size, 1)) SWIG_fail;
<a name="numpy.i-677"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-678"></a>}
<a name="numpy.i-679"></a>%typemap(freearg)
<a name="numpy.i-680"></a>  (DATA_TYPE IN_ARRAY1[ANY])
<a name="numpy.i-681"></a>{
<a name="numpy.i-682"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-683"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-684"></a>}
<a name="numpy.i-685"></a>
<a name="numpy.i-686"></a>/* Typemap suite for (DATA_TYPE* IN_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-687"></a> */
<a name="numpy.i-688"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-689"></a>           fragment="NumPy_Macros")
<a name="numpy.i-690"></a>  (DATA_TYPE* IN_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-691"></a>{
<a name="numpy.i-692"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-693"></a>}
<a name="numpy.i-694"></a>%typemap(in,
<a name="numpy.i-695"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-696"></a>  (DATA_TYPE* IN_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-697"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-698"></a>{
<a name="numpy.i-699"></a>  npy_intp size[1] = { -1 };
<a name="numpy.i-700"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-701"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-702"></a>                                                   &amp;is_new_object);
<a name="numpy.i-703"></a>  if (!array || !require_dimensions(array, 1) ||
<a name="numpy.i-704"></a>      !require_size(array, size, 1)) SWIG_fail;
<a name="numpy.i-705"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-706"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-707"></a>}
<a name="numpy.i-708"></a>%typemap(freearg)
<a name="numpy.i-709"></a>  (DATA_TYPE* IN_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-710"></a>{
<a name="numpy.i-711"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-712"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-713"></a>}
<a name="numpy.i-714"></a>
<a name="numpy.i-715"></a>/* Typemap suite for (DIM_TYPE DIM1, DATA_TYPE* IN_ARRAY1)
<a name="numpy.i-716"></a> */
<a name="numpy.i-717"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-718"></a>           fragment="NumPy_Macros")
<a name="numpy.i-719"></a>  (DIM_TYPE DIM1, DATA_TYPE* IN_ARRAY1)
<a name="numpy.i-720"></a>{
<a name="numpy.i-721"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-722"></a>}
<a name="numpy.i-723"></a>%typemap(in,
<a name="numpy.i-724"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-725"></a>  (DIM_TYPE DIM1, DATA_TYPE* IN_ARRAY1)
<a name="numpy.i-726"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-727"></a>{
<a name="numpy.i-728"></a>  npy_intp size[1] = {-1};
<a name="numpy.i-729"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-730"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-731"></a>                                                   &amp;is_new_object);
<a name="numpy.i-732"></a>  if (!array || !require_dimensions(array, 1) ||
<a name="numpy.i-733"></a>      !require_size(array, size, 1)) SWIG_fail;
<a name="numpy.i-734"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-735"></a>  $2 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-736"></a>}
<a name="numpy.i-737"></a>%typemap(freearg)
<a name="numpy.i-738"></a>  (DIM_TYPE DIM1, DATA_TYPE* IN_ARRAY1)
<a name="numpy.i-739"></a>{
<a name="numpy.i-740"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-741"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-742"></a>}
<a name="numpy.i-743"></a>
<a name="numpy.i-744"></a>/* Typemap suite for (DATA_TYPE IN_ARRAY2[ANY][ANY])
<a name="numpy.i-745"></a> */
<a name="numpy.i-746"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-747"></a>           fragment="NumPy_Macros")
<a name="numpy.i-748"></a>  (DATA_TYPE IN_ARRAY2[ANY][ANY])
<a name="numpy.i-749"></a>{
<a name="numpy.i-750"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-751"></a>}
<a name="numpy.i-752"></a>%typemap(in,
<a name="numpy.i-753"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-754"></a>  (DATA_TYPE IN_ARRAY2[ANY][ANY])
<a name="numpy.i-755"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-756"></a>{
<a name="numpy.i-757"></a>  npy_intp size[2] = { $1_dim0, $1_dim1 };
<a name="numpy.i-758"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-759"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-760"></a>                                                   &amp;is_new_object);
<a name="numpy.i-761"></a>  if (!array || !require_dimensions(array, 2) ||
<a name="numpy.i-762"></a>      !require_size(array, size, 2)) SWIG_fail;
<a name="numpy.i-763"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-764"></a>}
<a name="numpy.i-765"></a>%typemap(freearg)
<a name="numpy.i-766"></a>  (DATA_TYPE IN_ARRAY2[ANY][ANY])
<a name="numpy.i-767"></a>{
<a name="numpy.i-768"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-769"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-770"></a>}
<a name="numpy.i-771"></a>
<a name="numpy.i-772"></a>/* Typemap suite for (DATA_TYPE* IN_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-773"></a> */
<a name="numpy.i-774"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-775"></a>           fragment="NumPy_Macros")
<a name="numpy.i-776"></a>  (DATA_TYPE* IN_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-777"></a>{
<a name="numpy.i-778"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-779"></a>}
<a name="numpy.i-780"></a>%typemap(in,
<a name="numpy.i-781"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-782"></a>  (DATA_TYPE* IN_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-783"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-784"></a>{
<a name="numpy.i-785"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-786"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-787"></a>                                                   &amp;is_new_object);
<a name="numpy.i-788"></a>  if (!array || !require_dimensions(array, 2) ||
<a name="numpy.i-789"></a>      !require_size(array, size, 2)) SWIG_fail;
<a name="numpy.i-790"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-791"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-792"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-793"></a>}
<a name="numpy.i-794"></a>%typemap(freearg)
<a name="numpy.i-795"></a>  (DATA_TYPE* IN_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-796"></a>{
<a name="numpy.i-797"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-798"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-799"></a>}
<a name="numpy.i-800"></a>
<a name="numpy.i-801"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_ARRAY2)
<a name="numpy.i-802"></a> */
<a name="numpy.i-803"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-804"></a>           fragment="NumPy_Macros")
<a name="numpy.i-805"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_ARRAY2)
<a name="numpy.i-806"></a>{
<a name="numpy.i-807"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-808"></a>}
<a name="numpy.i-809"></a>%typemap(in,
<a name="numpy.i-810"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-811"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_ARRAY2)
<a name="numpy.i-812"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-813"></a>{
<a name="numpy.i-814"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-815"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-816"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-817"></a>                                                   &amp;is_new_object);
<a name="numpy.i-818"></a>  if (!array || !require_dimensions(array, 2) ||
<a name="numpy.i-819"></a>      !require_size(array, size, 2)) SWIG_fail;
<a name="numpy.i-820"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-821"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-822"></a>  $3 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-823"></a>}
<a name="numpy.i-824"></a>%typemap(freearg)
<a name="numpy.i-825"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_ARRAY2)
<a name="numpy.i-826"></a>{
<a name="numpy.i-827"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-828"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-829"></a>}
<a name="numpy.i-830"></a>
<a name="numpy.i-831"></a>/* Typemap suite for (DATA_TYPE* IN_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-832"></a> */
<a name="numpy.i-833"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-834"></a>           fragment="NumPy_Macros")
<a name="numpy.i-835"></a>  (DATA_TYPE* IN_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-836"></a>{
<a name="numpy.i-837"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-838"></a>}
<a name="numpy.i-839"></a>%typemap(in,
<a name="numpy.i-840"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-841"></a>  (DATA_TYPE* IN_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-842"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-843"></a>{
<a name="numpy.i-844"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-845"></a>  array = obj_to_array_fortran_allow_conversion($input,
<a name="numpy.i-846"></a>                                                DATA_TYPECODE,
<a name="numpy.i-847"></a>                                                &amp;is_new_object);
<a name="numpy.i-848"></a>  if (!array || !require_dimensions(array, 2) ||
<a name="numpy.i-849"></a>      !require_size(array, size, 2) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-850"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-851"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-852"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-853"></a>}
<a name="numpy.i-854"></a>%typemap(freearg)
<a name="numpy.i-855"></a>  (DATA_TYPE* IN_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-856"></a>{
<a name="numpy.i-857"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-858"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-859"></a>}
<a name="numpy.i-860"></a>
<a name="numpy.i-861"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_FARRAY2)
<a name="numpy.i-862"></a> */
<a name="numpy.i-863"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-864"></a>           fragment="NumPy_Macros")
<a name="numpy.i-865"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_FARRAY2)
<a name="numpy.i-866"></a>{
<a name="numpy.i-867"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-868"></a>}
<a name="numpy.i-869"></a>%typemap(in,
<a name="numpy.i-870"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-871"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_FARRAY2)
<a name="numpy.i-872"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-873"></a>{
<a name="numpy.i-874"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-875"></a>  array = obj_to_array_fortran_allow_conversion($input,
<a name="numpy.i-876"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-877"></a>                                                   &amp;is_new_object);
<a name="numpy.i-878"></a>  if (!array || !require_dimensions(array, 2) ||
<a name="numpy.i-879"></a>      !require_size(array, size, 2) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-880"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-881"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-882"></a>  $3 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-883"></a>}
<a name="numpy.i-884"></a>%typemap(freearg)
<a name="numpy.i-885"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* IN_FARRAY2)
<a name="numpy.i-886"></a>{
<a name="numpy.i-887"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-888"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-889"></a>}
<a name="numpy.i-890"></a>
<a name="numpy.i-891"></a>/* Typemap suite for (DATA_TYPE IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-892"></a> */
<a name="numpy.i-893"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-894"></a>           fragment="NumPy_Macros")
<a name="numpy.i-895"></a>  (DATA_TYPE IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-896"></a>{
<a name="numpy.i-897"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-898"></a>}
<a name="numpy.i-899"></a>%typemap(in,
<a name="numpy.i-900"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-901"></a>  (DATA_TYPE IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-902"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-903"></a>{
<a name="numpy.i-904"></a>  npy_intp size[3] = { $1_dim0, $1_dim1, $1_dim2 };
<a name="numpy.i-905"></a>  array = obj_to_array_contiguous_allow_conversion($input,
<a name="numpy.i-906"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-907"></a>                                                   &amp;is_new_object);
<a name="numpy.i-908"></a>  if (!array || !require_dimensions(array, 3) ||
<a name="numpy.i-909"></a>      !require_size(array, size, 3)) SWIG_fail;
<a name="numpy.i-910"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-911"></a>}
<a name="numpy.i-912"></a>%typemap(freearg)
<a name="numpy.i-913"></a>  (DATA_TYPE IN_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-914"></a>{
<a name="numpy.i-915"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-916"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-917"></a>}
<a name="numpy.i-918"></a>
<a name="numpy.i-919"></a>/* Typemap suite for (DATA_TYPE* IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-920"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-921"></a> */
<a name="numpy.i-922"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-923"></a>           fragment="NumPy_Macros")
<a name="numpy.i-924"></a>  (DATA_TYPE* IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-925"></a>{
<a name="numpy.i-926"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-927"></a>}
<a name="numpy.i-928"></a>%typemap(in,
<a name="numpy.i-929"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-930"></a>  (DATA_TYPE* IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-931"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-932"></a>{
<a name="numpy.i-933"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-934"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-935"></a>                                                   &amp;is_new_object);
<a name="numpy.i-936"></a>  if (!array || !require_dimensions(array, 3) ||
<a name="numpy.i-937"></a>      !require_size(array, size, 3)) SWIG_fail;
<a name="numpy.i-938"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-939"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-940"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-941"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-942"></a>}
<a name="numpy.i-943"></a>%typemap(freearg)
<a name="numpy.i-944"></a>  (DATA_TYPE* IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-945"></a>{
<a name="numpy.i-946"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-947"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-948"></a>}
<a name="numpy.i-949"></a>
<a name="numpy.i-950"></a>/* Typemap suite for (DATA_TYPE** IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-951"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-952"></a> */
<a name="numpy.i-953"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-954"></a>           fragment="NumPy_Macros")
<a name="numpy.i-955"></a>  (DATA_TYPE** IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-956"></a>{
<a name="numpy.i-957"></a>  /* for now, only concerned with lists */
<a name="numpy.i-958"></a>  $1 = PySequence_Check($input);
<a name="numpy.i-959"></a>}
<a name="numpy.i-960"></a>%typemap(in,
<a name="numpy.i-961"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-962"></a>  (DATA_TYPE** IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-963"></a>  (DATA_TYPE** array=NULL, PyArrayObject** object_array=NULL, int* is_new_object_array=NULL)
<a name="numpy.i-964"></a>{
<a name="numpy.i-965"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-966"></a>  PyArrayObject* temp_array;
<a name="numpy.i-967"></a>  Py_ssize_t i;
<a name="numpy.i-968"></a>  int is_new_object;
<a name="numpy.i-969"></a>
<a name="numpy.i-970"></a>  /* length of the list */
<a name="numpy.i-971"></a>  $2 = PyList_Size($input);
<a name="numpy.i-972"></a>
<a name="numpy.i-973"></a>  /* the arrays */
<a name="numpy.i-974"></a>  array = (DATA_TYPE **)malloc($2*sizeof(DATA_TYPE *));
<a name="numpy.i-975"></a>  object_array = (PyArrayObject **)calloc($2,sizeof(PyArrayObject *));
<a name="numpy.i-976"></a>  is_new_object_array = (int *)calloc($2,sizeof(int));
<a name="numpy.i-977"></a>
<a name="numpy.i-978"></a>  if (array == NULL || object_array == NULL || is_new_object_array == NULL)
<a name="numpy.i-979"></a>  {
<a name="numpy.i-980"></a>    SWIG_fail;
<a name="numpy.i-981"></a>  }
<a name="numpy.i-982"></a>
<a name="numpy.i-983"></a>  for (i=0; i&lt;$2; i++)
<a name="numpy.i-984"></a>  {
<a name="numpy.i-985"></a>    temp_array = obj_to_array_contiguous_allow_conversion(PySequence_GetItem($input,i), DATA_TYPECODE, &amp;is_new_object);
<a name="numpy.i-986"></a>
<a name="numpy.i-987"></a>    /* the new array must be stored so that it can be destroyed in freearg */
<a name="numpy.i-988"></a>    object_array[i] = temp_array;
<a name="numpy.i-989"></a>    is_new_object_array[i] = is_new_object;
<a name="numpy.i-990"></a>
<a name="numpy.i-991"></a>    if (!temp_array || !require_dimensions(temp_array, 2)) SWIG_fail;
<a name="numpy.i-992"></a>
<a name="numpy.i-993"></a>    /* store the size of the first array in the list, then use that for comparison. */
<a name="numpy.i-994"></a>    if (i == 0)
<a name="numpy.i-995"></a>    {
<a name="numpy.i-996"></a>      size[0] = array_size(temp_array,0);
<a name="numpy.i-997"></a>      size[1] = array_size(temp_array,1);
<a name="numpy.i-998"></a>    }
<a name="numpy.i-999"></a>
<a name="numpy.i-1000"></a>    if (!require_size(temp_array, size, 2)) SWIG_fail;
<a name="numpy.i-1001"></a>
<a name="numpy.i-1002"></a>    array[i] = (DATA_TYPE*) array_data(temp_array);
<a name="numpy.i-1003"></a>  }
<a name="numpy.i-1004"></a>
<a name="numpy.i-1005"></a>  $1 = (DATA_TYPE**) array;
<a name="numpy.i-1006"></a>  $3 = (DIM_TYPE) size[0];
<a name="numpy.i-1007"></a>  $4 = (DIM_TYPE) size[1];
<a name="numpy.i-1008"></a>}
<a name="numpy.i-1009"></a>%typemap(freearg)
<a name="numpy.i-1010"></a>  (DATA_TYPE** IN_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1011"></a>{
<a name="numpy.i-1012"></a>  Py_ssize_t i;
<a name="numpy.i-1013"></a>
<a name="numpy.i-1014"></a>  if (array$argnum!=NULL) free(array$argnum);
<a name="numpy.i-1015"></a>
<a name="numpy.i-1016"></a>  /*freeing the individual arrays if needed */
<a name="numpy.i-1017"></a>  if (object_array$argnum!=NULL)
<a name="numpy.i-1018"></a>  {
<a name="numpy.i-1019"></a>    if (is_new_object_array$argnum!=NULL)
<a name="numpy.i-1020"></a>    {
<a name="numpy.i-1021"></a>      for (i=0; i&lt;$2; i++)
<a name="numpy.i-1022"></a>      {
<a name="numpy.i-1023"></a>        if (object_array$argnum[i] != NULL &amp;&amp; is_new_object_array$argnum[i])
<a name="numpy.i-1024"></a>        { Py_DECREF(object_array$argnum[i]); }
<a name="numpy.i-1025"></a>      }
<a name="numpy.i-1026"></a>      free(is_new_object_array$argnum);
<a name="numpy.i-1027"></a>    }
<a name="numpy.i-1028"></a>    free(object_array$argnum);
<a name="numpy.i-1029"></a>  }
<a name="numpy.i-1030"></a>}
<a name="numpy.i-1031"></a>
<a name="numpy.i-1032"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3,
<a name="numpy.i-1033"></a> *                    DATA_TYPE* IN_ARRAY3)
<a name="numpy.i-1034"></a> */
<a name="numpy.i-1035"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1036"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1037"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_ARRAY3)
<a name="numpy.i-1038"></a>{
<a name="numpy.i-1039"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1040"></a>}
<a name="numpy.i-1041"></a>%typemap(in,
<a name="numpy.i-1042"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1043"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_ARRAY3)
<a name="numpy.i-1044"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1045"></a>{
<a name="numpy.i-1046"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-1047"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1048"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1049"></a>  if (!array || !require_dimensions(array, 3) ||
<a name="numpy.i-1050"></a>      !require_size(array, size, 3)) SWIG_fail;
<a name="numpy.i-1051"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1052"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1053"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1054"></a>  $4 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1055"></a>}
<a name="numpy.i-1056"></a>%typemap(freearg)
<a name="numpy.i-1057"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_ARRAY3)
<a name="numpy.i-1058"></a>{
<a name="numpy.i-1059"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1060"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1061"></a>}
<a name="numpy.i-1062"></a>
<a name="numpy.i-1063"></a>/* Typemap suite for (DATA_TYPE* IN_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1064"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-1065"></a> */
<a name="numpy.i-1066"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1067"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1068"></a>  (DATA_TYPE* IN_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1069"></a>{
<a name="numpy.i-1070"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1071"></a>}
<a name="numpy.i-1072"></a>%typemap(in,
<a name="numpy.i-1073"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1074"></a>  (DATA_TYPE* IN_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1075"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1076"></a>{
<a name="numpy.i-1077"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-1078"></a>  array = obj_to_array_fortran_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1079"></a>                                                &amp;is_new_object);
<a name="numpy.i-1080"></a>  if (!array || !require_dimensions(array, 3) ||
<a name="numpy.i-1081"></a>      !require_size(array, size, 3) | !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1082"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1083"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1084"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1085"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1086"></a>}
<a name="numpy.i-1087"></a>%typemap(freearg)
<a name="numpy.i-1088"></a>  (DATA_TYPE* IN_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1089"></a>{
<a name="numpy.i-1090"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1091"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1092"></a>}
<a name="numpy.i-1093"></a>
<a name="numpy.i-1094"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3,
<a name="numpy.i-1095"></a> *                    DATA_TYPE* IN_FARRAY3)
<a name="numpy.i-1096"></a> */
<a name="numpy.i-1097"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1098"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1099"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_FARRAY3)
<a name="numpy.i-1100"></a>{
<a name="numpy.i-1101"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1102"></a>}
<a name="numpy.i-1103"></a>%typemap(in,
<a name="numpy.i-1104"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1105"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_FARRAY3)
<a name="numpy.i-1106"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1107"></a>{
<a name="numpy.i-1108"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-1109"></a>  array = obj_to_array_fortran_allow_conversion($input,
<a name="numpy.i-1110"></a>                                                   DATA_TYPECODE,
<a name="numpy.i-1111"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1112"></a>  if (!array || !require_dimensions(array, 3) ||
<a name="numpy.i-1113"></a>      !require_size(array, size, 3) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1114"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1115"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1116"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1117"></a>  $4 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1118"></a>}
<a name="numpy.i-1119"></a>%typemap(freearg)
<a name="numpy.i-1120"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* IN_FARRAY3)
<a name="numpy.i-1121"></a>{
<a name="numpy.i-1122"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1123"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1124"></a>}
<a name="numpy.i-1125"></a>
<a name="numpy.i-1126"></a>/* Typemap suite for (DATA_TYPE IN_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1127"></a> */
<a name="numpy.i-1128"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1129"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1130"></a>  (DATA_TYPE IN_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1131"></a>{
<a name="numpy.i-1132"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1133"></a>}
<a name="numpy.i-1134"></a>%typemap(in,
<a name="numpy.i-1135"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1136"></a>  (DATA_TYPE IN_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1137"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1138"></a>{
<a name="numpy.i-1139"></a>  npy_intp size[4] = { $1_dim0, $1_dim1, $1_dim2 , $1_dim3};
<a name="numpy.i-1140"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1141"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1142"></a>  if (!array || !require_dimensions(array, 4) ||
<a name="numpy.i-1143"></a>      !require_size(array, size, 4)) SWIG_fail;
<a name="numpy.i-1144"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1145"></a>}
<a name="numpy.i-1146"></a>%typemap(freearg)
<a name="numpy.i-1147"></a>  (DATA_TYPE IN_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1148"></a>{
<a name="numpy.i-1149"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1150"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1151"></a>}
<a name="numpy.i-1152"></a>
<a name="numpy.i-1153"></a>/* Typemap suite for (DATA_TYPE* IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1154"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1155"></a> */
<a name="numpy.i-1156"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1157"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1158"></a>  (DATA_TYPE* IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1159"></a>{
<a name="numpy.i-1160"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1161"></a>}
<a name="numpy.i-1162"></a>%typemap(in,
<a name="numpy.i-1163"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1164"></a>  (DATA_TYPE* IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1165"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1166"></a>{
<a name="numpy.i-1167"></a>  npy_intp size[4] = { -1, -1, -1, -1 };
<a name="numpy.i-1168"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1169"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1170"></a>  if (!array || !require_dimensions(array, 4) ||
<a name="numpy.i-1171"></a>      !require_size(array, size, 4)) SWIG_fail;
<a name="numpy.i-1172"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1173"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1174"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1175"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1176"></a>  $5 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1177"></a>}
<a name="numpy.i-1178"></a>%typemap(freearg)
<a name="numpy.i-1179"></a>  (DATA_TYPE* IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1180"></a>{
<a name="numpy.i-1181"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1182"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1183"></a>}
<a name="numpy.i-1184"></a>
<a name="numpy.i-1185"></a>/* Typemap suite for (DATA_TYPE** IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1186"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1187"></a> */
<a name="numpy.i-1188"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1189"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1190"></a>  (DATA_TYPE** IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1191"></a>{
<a name="numpy.i-1192"></a>  /* for now, only concerned with lists */
<a name="numpy.i-1193"></a>  $1 = PySequence_Check($input);
<a name="numpy.i-1194"></a>}
<a name="numpy.i-1195"></a>%typemap(in,
<a name="numpy.i-1196"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1197"></a>  (DATA_TYPE** IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1198"></a>  (DATA_TYPE** array=NULL, PyArrayObject** object_array=NULL, int* is_new_object_array=NULL)
<a name="numpy.i-1199"></a>{
<a name="numpy.i-1200"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-1201"></a>  PyArrayObject* temp_array;
<a name="numpy.i-1202"></a>  Py_ssize_t i;
<a name="numpy.i-1203"></a>  int is_new_object;
<a name="numpy.i-1204"></a>
<a name="numpy.i-1205"></a>  /* length of the list */
<a name="numpy.i-1206"></a>  $2 = PyList_Size($input);
<a name="numpy.i-1207"></a>
<a name="numpy.i-1208"></a>  /* the arrays */
<a name="numpy.i-1209"></a>  array = (DATA_TYPE **)malloc($2*sizeof(DATA_TYPE *));
<a name="numpy.i-1210"></a>  object_array = (PyArrayObject **)calloc($2,sizeof(PyArrayObject *));
<a name="numpy.i-1211"></a>  is_new_object_array = (int *)calloc($2,sizeof(int));
<a name="numpy.i-1212"></a>
<a name="numpy.i-1213"></a>  if (array == NULL || object_array == NULL || is_new_object_array == NULL)
<a name="numpy.i-1214"></a>  {
<a name="numpy.i-1215"></a>    SWIG_fail;
<a name="numpy.i-1216"></a>  }
<a name="numpy.i-1217"></a>
<a name="numpy.i-1218"></a>  for (i=0; i&lt;$2; i++)
<a name="numpy.i-1219"></a>  {
<a name="numpy.i-1220"></a>    temp_array = obj_to_array_contiguous_allow_conversion(PySequence_GetItem($input,i), DATA_TYPECODE, &amp;is_new_object);
<a name="numpy.i-1221"></a>
<a name="numpy.i-1222"></a>    /* the new array must be stored so that it can be destroyed in freearg */
<a name="numpy.i-1223"></a>    object_array[i] = temp_array;
<a name="numpy.i-1224"></a>    is_new_object_array[i] = is_new_object;
<a name="numpy.i-1225"></a>
<a name="numpy.i-1226"></a>    if (!temp_array || !require_dimensions(temp_array, 3)) SWIG_fail;
<a name="numpy.i-1227"></a>
<a name="numpy.i-1228"></a>    /* store the size of the first array in the list, then use that for comparison. */
<a name="numpy.i-1229"></a>    if (i == 0)
<a name="numpy.i-1230"></a>    {
<a name="numpy.i-1231"></a>      size[0] = array_size(temp_array,0);
<a name="numpy.i-1232"></a>      size[1] = array_size(temp_array,1);
<a name="numpy.i-1233"></a>      size[2] = array_size(temp_array,2);
<a name="numpy.i-1234"></a>    }
<a name="numpy.i-1235"></a>
<a name="numpy.i-1236"></a>    if (!require_size(temp_array, size, 3)) SWIG_fail;
<a name="numpy.i-1237"></a>
<a name="numpy.i-1238"></a>    array[i] = (DATA_TYPE*) array_data(temp_array);
<a name="numpy.i-1239"></a>  }
<a name="numpy.i-1240"></a>
<a name="numpy.i-1241"></a>  $1 = (DATA_TYPE**) array;
<a name="numpy.i-1242"></a>  $3 = (DIM_TYPE) size[0];
<a name="numpy.i-1243"></a>  $4 = (DIM_TYPE) size[1];
<a name="numpy.i-1244"></a>  $5 = (DIM_TYPE) size[2];
<a name="numpy.i-1245"></a>}
<a name="numpy.i-1246"></a>%typemap(freearg)
<a name="numpy.i-1247"></a>  (DATA_TYPE** IN_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1248"></a>{
<a name="numpy.i-1249"></a>  Py_ssize_t i;
<a name="numpy.i-1250"></a>
<a name="numpy.i-1251"></a>  if (array$argnum!=NULL) free(array$argnum);
<a name="numpy.i-1252"></a>
<a name="numpy.i-1253"></a>  /*freeing the individual arrays if needed */
<a name="numpy.i-1254"></a>  if (object_array$argnum!=NULL)
<a name="numpy.i-1255"></a>  {
<a name="numpy.i-1256"></a>    if (is_new_object_array$argnum!=NULL)
<a name="numpy.i-1257"></a>    {
<a name="numpy.i-1258"></a>      for (i=0; i&lt;$2; i++)
<a name="numpy.i-1259"></a>      {
<a name="numpy.i-1260"></a>        if (object_array$argnum[i] != NULL &amp;&amp; is_new_object_array$argnum[i])
<a name="numpy.i-1261"></a>        { Py_DECREF(object_array$argnum[i]); }
<a name="numpy.i-1262"></a>      }
<a name="numpy.i-1263"></a>      free(is_new_object_array$argnum);
<a name="numpy.i-1264"></a>    }
<a name="numpy.i-1265"></a>    free(object_array$argnum);
<a name="numpy.i-1266"></a>  }
<a name="numpy.i-1267"></a>}
<a name="numpy.i-1268"></a>
<a name="numpy.i-1269"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4,
<a name="numpy.i-1270"></a> *                    DATA_TYPE* IN_ARRAY4)
<a name="numpy.i-1271"></a> */
<a name="numpy.i-1272"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1273"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1274"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_ARRAY4)
<a name="numpy.i-1275"></a>{
<a name="numpy.i-1276"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1277"></a>}
<a name="numpy.i-1278"></a>%typemap(in,
<a name="numpy.i-1279"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1280"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_ARRAY4)
<a name="numpy.i-1281"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1282"></a>{
<a name="numpy.i-1283"></a>  npy_intp size[4] = { -1, -1, -1 , -1};
<a name="numpy.i-1284"></a>  array = obj_to_array_contiguous_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1285"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1286"></a>  if (!array || !require_dimensions(array, 4) ||
<a name="numpy.i-1287"></a>      !require_size(array, size, 4)) SWIG_fail;
<a name="numpy.i-1288"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1289"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1290"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1291"></a>  $4 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1292"></a>  $5 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1293"></a>}
<a name="numpy.i-1294"></a>%typemap(freearg)
<a name="numpy.i-1295"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_ARRAY4)
<a name="numpy.i-1296"></a>{
<a name="numpy.i-1297"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1298"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1299"></a>}
<a name="numpy.i-1300"></a>
<a name="numpy.i-1301"></a>/* Typemap suite for (DATA_TYPE* IN_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1302"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1303"></a> */
<a name="numpy.i-1304"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1305"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1306"></a>  (DATA_TYPE* IN_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1307"></a>{
<a name="numpy.i-1308"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1309"></a>}
<a name="numpy.i-1310"></a>%typemap(in,
<a name="numpy.i-1311"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1312"></a>  (DATA_TYPE* IN_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1313"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1314"></a>{
<a name="numpy.i-1315"></a>  npy_intp size[4] = { -1, -1, -1, -1 };
<a name="numpy.i-1316"></a>  array = obj_to_array_fortran_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1317"></a>                                                &amp;is_new_object);
<a name="numpy.i-1318"></a>  if (!array || !require_dimensions(array, 4) ||
<a name="numpy.i-1319"></a>      !require_size(array, size, 4) | !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1320"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1321"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1322"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1323"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1324"></a>  $5 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1325"></a>}
<a name="numpy.i-1326"></a>%typemap(freearg)
<a name="numpy.i-1327"></a>  (DATA_TYPE* IN_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1328"></a>{
<a name="numpy.i-1329"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1330"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1331"></a>}
<a name="numpy.i-1332"></a>
<a name="numpy.i-1333"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4,
<a name="numpy.i-1334"></a> *                    DATA_TYPE* IN_FARRAY4)
<a name="numpy.i-1335"></a> */
<a name="numpy.i-1336"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1337"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1338"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_FARRAY4)
<a name="numpy.i-1339"></a>{
<a name="numpy.i-1340"></a>  $1 = is_array($input) || PySequence_Check($input);
<a name="numpy.i-1341"></a>}
<a name="numpy.i-1342"></a>%typemap(in,
<a name="numpy.i-1343"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1344"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_FARRAY4)
<a name="numpy.i-1345"></a>  (PyArrayObject* array=NULL, int is_new_object=0)
<a name="numpy.i-1346"></a>{
<a name="numpy.i-1347"></a>  npy_intp size[4] = { -1, -1, -1 , -1 };
<a name="numpy.i-1348"></a>  array = obj_to_array_fortran_allow_conversion($input, DATA_TYPECODE,
<a name="numpy.i-1349"></a>                                                   &amp;is_new_object);
<a name="numpy.i-1350"></a>  if (!array || !require_dimensions(array, 4) ||
<a name="numpy.i-1351"></a>      !require_size(array, size, 4) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1352"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1353"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1354"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1355"></a>  $4 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1356"></a>  $5 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1357"></a>}
<a name="numpy.i-1358"></a>%typemap(freearg)
<a name="numpy.i-1359"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* IN_FARRAY4)
<a name="numpy.i-1360"></a>{
<a name="numpy.i-1361"></a>  if (is_new_object$argnum &amp;&amp; array$argnum)
<a name="numpy.i-1362"></a>    { Py_DECREF(array$argnum); }
<a name="numpy.i-1363"></a>}
<a name="numpy.i-1364"></a>
<a name="numpy.i-1365"></a>/***************************/
<a name="numpy.i-1366"></a>/* In-Place Array Typemaps */
<a name="numpy.i-1367"></a>/***************************/
<a name="numpy.i-1368"></a>
<a name="numpy.i-1369"></a>/* Typemap suite for (DATA_TYPE INPLACE_ARRAY1[ANY])
<a name="numpy.i-1370"></a> */
<a name="numpy.i-1371"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1372"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1373"></a>  (DATA_TYPE INPLACE_ARRAY1[ANY])
<a name="numpy.i-1374"></a>{
<a name="numpy.i-1375"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1376"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1377"></a>}
<a name="numpy.i-1378"></a>%typemap(in,
<a name="numpy.i-1379"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1380"></a>  (DATA_TYPE INPLACE_ARRAY1[ANY])
<a name="numpy.i-1381"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1382"></a>{
<a name="numpy.i-1383"></a>  npy_intp size[1] = { $1_dim0 };
<a name="numpy.i-1384"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1385"></a>  if (!array || !require_dimensions(array,1) || !require_size(array, size, 1) ||
<a name="numpy.i-1386"></a>      !require_contiguous(array) || !require_native(array)) SWIG_fail;
<a name="numpy.i-1387"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1388"></a>}
<a name="numpy.i-1389"></a>
<a name="numpy.i-1390"></a>/* Typemap suite for (DATA_TYPE* INPLACE_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1391"></a> */
<a name="numpy.i-1392"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1393"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1394"></a>  (DATA_TYPE* INPLACE_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1395"></a>{
<a name="numpy.i-1396"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1397"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1398"></a>}
<a name="numpy.i-1399"></a>%typemap(in,
<a name="numpy.i-1400"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1401"></a>  (DATA_TYPE* INPLACE_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1402"></a>  (PyArrayObject* array=NULL, int i=1)
<a name="numpy.i-1403"></a>{
<a name="numpy.i-1404"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1405"></a>  if (!array || !require_dimensions(array,1) || !require_contiguous(array)
<a name="numpy.i-1406"></a>      || !require_native(array)) SWIG_fail;
<a name="numpy.i-1407"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1408"></a>  $2 = 1;
<a name="numpy.i-1409"></a>  for (i=0; i &lt; array_numdims(array); ++i) $2 *= array_size(array,i);
<a name="numpy.i-1410"></a>}
<a name="numpy.i-1411"></a>
<a name="numpy.i-1412"></a>/* Typemap suite for (DIM_TYPE DIM1, DATA_TYPE* INPLACE_ARRAY1)
<a name="numpy.i-1413"></a> */
<a name="numpy.i-1414"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1415"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1416"></a>  (DIM_TYPE DIM1, DATA_TYPE* INPLACE_ARRAY1)
<a name="numpy.i-1417"></a>{
<a name="numpy.i-1418"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1419"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1420"></a>}
<a name="numpy.i-1421"></a>%typemap(in,
<a name="numpy.i-1422"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1423"></a>  (DIM_TYPE DIM1, DATA_TYPE* INPLACE_ARRAY1)
<a name="numpy.i-1424"></a>  (PyArrayObject* array=NULL, int i=0)
<a name="numpy.i-1425"></a>{
<a name="numpy.i-1426"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1427"></a>  if (!array || !require_dimensions(array,1) || !require_contiguous(array)
<a name="numpy.i-1428"></a>      || !require_native(array)) SWIG_fail;
<a name="numpy.i-1429"></a>  $1 = 1;
<a name="numpy.i-1430"></a>  for (i=0; i &lt; array_numdims(array); ++i) $1 *= array_size(array,i);
<a name="numpy.i-1431"></a>  $2 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1432"></a>}
<a name="numpy.i-1433"></a>
<a name="numpy.i-1434"></a>/* Typemap suite for (DATA_TYPE INPLACE_ARRAY2[ANY][ANY])
<a name="numpy.i-1435"></a> */
<a name="numpy.i-1436"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1437"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1438"></a>  (DATA_TYPE INPLACE_ARRAY2[ANY][ANY])
<a name="numpy.i-1439"></a>{
<a name="numpy.i-1440"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1441"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1442"></a>}
<a name="numpy.i-1443"></a>%typemap(in,
<a name="numpy.i-1444"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1445"></a>  (DATA_TYPE INPLACE_ARRAY2[ANY][ANY])
<a name="numpy.i-1446"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1447"></a>{
<a name="numpy.i-1448"></a>  npy_intp size[2] = { $1_dim0, $1_dim1 };
<a name="numpy.i-1449"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1450"></a>  if (!array || !require_dimensions(array,2) || !require_size(array, size, 2) ||
<a name="numpy.i-1451"></a>      !require_contiguous(array) || !require_native(array)) SWIG_fail;
<a name="numpy.i-1452"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1453"></a>}
<a name="numpy.i-1454"></a>
<a name="numpy.i-1455"></a>/* Typemap suite for (DATA_TYPE* INPLACE_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1456"></a> */
<a name="numpy.i-1457"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1458"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1459"></a>  (DATA_TYPE* INPLACE_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1460"></a>{
<a name="numpy.i-1461"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1462"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1463"></a>}
<a name="numpy.i-1464"></a>%typemap(in,
<a name="numpy.i-1465"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1466"></a>  (DATA_TYPE* INPLACE_ARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1467"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1468"></a>{
<a name="numpy.i-1469"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1470"></a>  if (!array || !require_dimensions(array,2) || !require_contiguous(array)
<a name="numpy.i-1471"></a>      || !require_native(array)) SWIG_fail;
<a name="numpy.i-1472"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1473"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1474"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1475"></a>}
<a name="numpy.i-1476"></a>
<a name="numpy.i-1477"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_ARRAY2)
<a name="numpy.i-1478"></a> */
<a name="numpy.i-1479"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1480"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1481"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_ARRAY2)
<a name="numpy.i-1482"></a>{
<a name="numpy.i-1483"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1484"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1485"></a>}
<a name="numpy.i-1486"></a>%typemap(in,
<a name="numpy.i-1487"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1488"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_ARRAY2)
<a name="numpy.i-1489"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1490"></a>{
<a name="numpy.i-1491"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1492"></a>  if (!array || !require_dimensions(array,2) || !require_contiguous(array) ||
<a name="numpy.i-1493"></a>      !require_native(array)) SWIG_fail;
<a name="numpy.i-1494"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1495"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1496"></a>  $3 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1497"></a>}
<a name="numpy.i-1498"></a>
<a name="numpy.i-1499"></a>/* Typemap suite for (DATA_TYPE* INPLACE_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1500"></a> */
<a name="numpy.i-1501"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1502"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1503"></a>  (DATA_TYPE* INPLACE_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1504"></a>{
<a name="numpy.i-1505"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1506"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1507"></a>}
<a name="numpy.i-1508"></a>%typemap(in,
<a name="numpy.i-1509"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1510"></a>  (DATA_TYPE* INPLACE_FARRAY2, DIM_TYPE DIM1, DIM_TYPE DIM2)
<a name="numpy.i-1511"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1512"></a>{
<a name="numpy.i-1513"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1514"></a>  if (!array || !require_dimensions(array,2) || !require_contiguous(array)
<a name="numpy.i-1515"></a>      || !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1516"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1517"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1518"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1519"></a>}
<a name="numpy.i-1520"></a>
<a name="numpy.i-1521"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_FARRAY2)
<a name="numpy.i-1522"></a> */
<a name="numpy.i-1523"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1524"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1525"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_FARRAY2)
<a name="numpy.i-1526"></a>{
<a name="numpy.i-1527"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1528"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1529"></a>}
<a name="numpy.i-1530"></a>%typemap(in,
<a name="numpy.i-1531"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1532"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DATA_TYPE* INPLACE_FARRAY2)
<a name="numpy.i-1533"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1534"></a>{
<a name="numpy.i-1535"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1536"></a>  if (!array || !require_dimensions(array,2) || !require_contiguous(array) ||
<a name="numpy.i-1537"></a>      !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1538"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1539"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1540"></a>  $3 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1541"></a>}
<a name="numpy.i-1542"></a>
<a name="numpy.i-1543"></a>/* Typemap suite for (DATA_TYPE INPLACE_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-1544"></a> */
<a name="numpy.i-1545"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1546"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1547"></a>  (DATA_TYPE INPLACE_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-1548"></a>{
<a name="numpy.i-1549"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1550"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1551"></a>}
<a name="numpy.i-1552"></a>%typemap(in,
<a name="numpy.i-1553"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1554"></a>  (DATA_TYPE INPLACE_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-1555"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1556"></a>{
<a name="numpy.i-1557"></a>  npy_intp size[3] = { $1_dim0, $1_dim1, $1_dim2 };
<a name="numpy.i-1558"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1559"></a>  if (!array || !require_dimensions(array,3) || !require_size(array, size, 3) ||
<a name="numpy.i-1560"></a>      !require_contiguous(array) || !require_native(array)) SWIG_fail;
<a name="numpy.i-1561"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1562"></a>}
<a name="numpy.i-1563"></a>
<a name="numpy.i-1564"></a>/* Typemap suite for (DATA_TYPE* INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1565"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-1566"></a> */
<a name="numpy.i-1567"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1568"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1569"></a>  (DATA_TYPE* INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1570"></a>{
<a name="numpy.i-1571"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1572"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1573"></a>}
<a name="numpy.i-1574"></a>%typemap(in,
<a name="numpy.i-1575"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1576"></a>  (DATA_TYPE* INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1577"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1578"></a>{
<a name="numpy.i-1579"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1580"></a>  if (!array || !require_dimensions(array,3) || !require_contiguous(array) ||
<a name="numpy.i-1581"></a>      !require_native(array)) SWIG_fail;
<a name="numpy.i-1582"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1583"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1584"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1585"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1586"></a>}
<a name="numpy.i-1587"></a>
<a name="numpy.i-1588"></a>/* Typemap suite for (DATA_TYPE** INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1589"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-1590"></a> */
<a name="numpy.i-1591"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1592"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1593"></a>  (DATA_TYPE** INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1594"></a>{
<a name="numpy.i-1595"></a>  $1 = PySequence_Check($input);
<a name="numpy.i-1596"></a>}
<a name="numpy.i-1597"></a>%typemap(in,
<a name="numpy.i-1598"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1599"></a>  (DATA_TYPE** INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1600"></a>  (DATA_TYPE** array=NULL, PyArrayObject** object_array=NULL)
<a name="numpy.i-1601"></a>{
<a name="numpy.i-1602"></a>  npy_intp size[2] = { -1, -1 };
<a name="numpy.i-1603"></a>  PyArrayObject* temp_array;
<a name="numpy.i-1604"></a>  Py_ssize_t i;
<a name="numpy.i-1605"></a>
<a name="numpy.i-1606"></a>  /* length of the list */
<a name="numpy.i-1607"></a>  $2 = PyList_Size($input);
<a name="numpy.i-1608"></a>
<a name="numpy.i-1609"></a>  /* the arrays */
<a name="numpy.i-1610"></a>  array = (DATA_TYPE **)malloc($2*sizeof(DATA_TYPE *));
<a name="numpy.i-1611"></a>  object_array = (PyArrayObject **)calloc($2,sizeof(PyArrayObject *));
<a name="numpy.i-1612"></a>
<a name="numpy.i-1613"></a>  if (array == NULL || object_array == NULL)
<a name="numpy.i-1614"></a>  {
<a name="numpy.i-1615"></a>    SWIG_fail;
<a name="numpy.i-1616"></a>  }
<a name="numpy.i-1617"></a>
<a name="numpy.i-1618"></a>  for (i=0; i&lt;$2; i++)
<a name="numpy.i-1619"></a>  {
<a name="numpy.i-1620"></a>    temp_array = obj_to_array_no_conversion(PySequence_GetItem($input,i), DATA_TYPECODE);
<a name="numpy.i-1621"></a>
<a name="numpy.i-1622"></a>    /* the new array must be stored so that it can be destroyed in freearg */
<a name="numpy.i-1623"></a>    object_array[i] = temp_array;
<a name="numpy.i-1624"></a>
<a name="numpy.i-1625"></a>    if ( !temp_array || !require_dimensions(temp_array, 2) ||
<a name="numpy.i-1626"></a>      !require_contiguous(temp_array) ||
<a name="numpy.i-1627"></a>      !require_native(temp_array) ||
<a name="numpy.i-1628"></a>      !PyArray_EquivTypenums(array_type(temp_array), DATA_TYPECODE)
<a name="numpy.i-1629"></a>    ) SWIG_fail;
<a name="numpy.i-1630"></a>
<a name="numpy.i-1631"></a>    /* store the size of the first array in the list, then use that for comparison. */
<a name="numpy.i-1632"></a>    if (i == 0)
<a name="numpy.i-1633"></a>    {
<a name="numpy.i-1634"></a>      size[0] = array_size(temp_array,0);
<a name="numpy.i-1635"></a>      size[1] = array_size(temp_array,1);
<a name="numpy.i-1636"></a>    }
<a name="numpy.i-1637"></a>
<a name="numpy.i-1638"></a>    if (!require_size(temp_array, size, 2)) SWIG_fail;
<a name="numpy.i-1639"></a>
<a name="numpy.i-1640"></a>    array[i] = (DATA_TYPE*) array_data(temp_array);
<a name="numpy.i-1641"></a>  }
<a name="numpy.i-1642"></a>
<a name="numpy.i-1643"></a>  $1 = (DATA_TYPE**) array;
<a name="numpy.i-1644"></a>  $3 = (DIM_TYPE) size[0];
<a name="numpy.i-1645"></a>  $4 = (DIM_TYPE) size[1];
<a name="numpy.i-1646"></a>}
<a name="numpy.i-1647"></a>%typemap(freearg)
<a name="numpy.i-1648"></a>  (DATA_TYPE** INPLACE_ARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1649"></a>{
<a name="numpy.i-1650"></a>  if (array$argnum!=NULL) free(array$argnum);
<a name="numpy.i-1651"></a>  if (object_array$argnum!=NULL) free(object_array$argnum);
<a name="numpy.i-1652"></a>}
<a name="numpy.i-1653"></a>
<a name="numpy.i-1654"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3,
<a name="numpy.i-1655"></a> *                    DATA_TYPE* INPLACE_ARRAY3)
<a name="numpy.i-1656"></a> */
<a name="numpy.i-1657"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1658"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1659"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_ARRAY3)
<a name="numpy.i-1660"></a>{
<a name="numpy.i-1661"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1662"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1663"></a>}
<a name="numpy.i-1664"></a>%typemap(in,
<a name="numpy.i-1665"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1666"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_ARRAY3)
<a name="numpy.i-1667"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1668"></a>{
<a name="numpy.i-1669"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1670"></a>  if (!array || !require_dimensions(array,3) || !require_contiguous(array)
<a name="numpy.i-1671"></a>      || !require_native(array)) SWIG_fail;
<a name="numpy.i-1672"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1673"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1674"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1675"></a>  $4 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1676"></a>}
<a name="numpy.i-1677"></a>
<a name="numpy.i-1678"></a>/* Typemap suite for (DATA_TYPE* INPLACE_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1679"></a> *                    DIM_TYPE DIM3)
<a name="numpy.i-1680"></a> */
<a name="numpy.i-1681"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1682"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1683"></a>  (DATA_TYPE* INPLACE_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1684"></a>{
<a name="numpy.i-1685"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1686"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1687"></a>}
<a name="numpy.i-1688"></a>%typemap(in,
<a name="numpy.i-1689"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1690"></a>  (DATA_TYPE* INPLACE_FARRAY3, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3)
<a name="numpy.i-1691"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1692"></a>{
<a name="numpy.i-1693"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1694"></a>  if (!array || !require_dimensions(array,3) || !require_contiguous(array) ||
<a name="numpy.i-1695"></a>      !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1696"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1697"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1698"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1699"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1700"></a>}
<a name="numpy.i-1701"></a>
<a name="numpy.i-1702"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3,
<a name="numpy.i-1703"></a> *                    DATA_TYPE* INPLACE_FARRAY3)
<a name="numpy.i-1704"></a> */
<a name="numpy.i-1705"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1706"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1707"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_FARRAY3)
<a name="numpy.i-1708"></a>{
<a name="numpy.i-1709"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1710"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1711"></a>}
<a name="numpy.i-1712"></a>%typemap(in,
<a name="numpy.i-1713"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1714"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DATA_TYPE* INPLACE_FARRAY3)
<a name="numpy.i-1715"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1716"></a>{
<a name="numpy.i-1717"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1718"></a>  if (!array || !require_dimensions(array,3) || !require_contiguous(array)
<a name="numpy.i-1719"></a>      || !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1720"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1721"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1722"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1723"></a>  $4 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1724"></a>}
<a name="numpy.i-1725"></a>
<a name="numpy.i-1726"></a>/* Typemap suite for (DATA_TYPE INPLACE_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1727"></a> */
<a name="numpy.i-1728"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1729"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1730"></a>  (DATA_TYPE INPLACE_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1731"></a>{
<a name="numpy.i-1732"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1733"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1734"></a>}
<a name="numpy.i-1735"></a>%typemap(in,
<a name="numpy.i-1736"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1737"></a>  (DATA_TYPE INPLACE_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-1738"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1739"></a>{
<a name="numpy.i-1740"></a>  npy_intp size[4] = { $1_dim0, $1_dim1, $1_dim2 , $1_dim3 };
<a name="numpy.i-1741"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1742"></a>  if (!array || !require_dimensions(array,4) || !require_size(array, size, 4) ||
<a name="numpy.i-1743"></a>      !require_contiguous(array) || !require_native(array)) SWIG_fail;
<a name="numpy.i-1744"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1745"></a>}
<a name="numpy.i-1746"></a>
<a name="numpy.i-1747"></a>/* Typemap suite for (DATA_TYPE* INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1748"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1749"></a> */
<a name="numpy.i-1750"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1751"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1752"></a>  (DATA_TYPE* INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1753"></a>{
<a name="numpy.i-1754"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1755"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1756"></a>}
<a name="numpy.i-1757"></a>%typemap(in,
<a name="numpy.i-1758"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1759"></a>  (DATA_TYPE* INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1760"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1761"></a>{
<a name="numpy.i-1762"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1763"></a>  if (!array || !require_dimensions(array,4) || !require_contiguous(array) ||
<a name="numpy.i-1764"></a>      !require_native(array)) SWIG_fail;
<a name="numpy.i-1765"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1766"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1767"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1768"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1769"></a>  $5 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1770"></a>}
<a name="numpy.i-1771"></a>
<a name="numpy.i-1772"></a>/* Typemap suite for (DATA_TYPE** INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1773"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1774"></a> */
<a name="numpy.i-1775"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1776"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1777"></a>  (DATA_TYPE** INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1778"></a>{
<a name="numpy.i-1779"></a>  $1 = PySequence_Check($input);
<a name="numpy.i-1780"></a>}
<a name="numpy.i-1781"></a>%typemap(in,
<a name="numpy.i-1782"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1783"></a>  (DATA_TYPE** INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1784"></a>  (DATA_TYPE** array=NULL, PyArrayObject** object_array=NULL)
<a name="numpy.i-1785"></a>{
<a name="numpy.i-1786"></a>  npy_intp size[3] = { -1, -1, -1 };
<a name="numpy.i-1787"></a>  PyArrayObject* temp_array;
<a name="numpy.i-1788"></a>  Py_ssize_t i;
<a name="numpy.i-1789"></a>
<a name="numpy.i-1790"></a>  /* length of the list */
<a name="numpy.i-1791"></a>  $2 = PyList_Size($input);
<a name="numpy.i-1792"></a>
<a name="numpy.i-1793"></a>  /* the arrays */
<a name="numpy.i-1794"></a>  array = (DATA_TYPE **)malloc($2*sizeof(DATA_TYPE *));
<a name="numpy.i-1795"></a>  object_array = (PyArrayObject **)calloc($2,sizeof(PyArrayObject *));
<a name="numpy.i-1796"></a>
<a name="numpy.i-1797"></a>  if (array == NULL || object_array == NULL)
<a name="numpy.i-1798"></a>  {
<a name="numpy.i-1799"></a>    SWIG_fail;
<a name="numpy.i-1800"></a>  }
<a name="numpy.i-1801"></a>
<a name="numpy.i-1802"></a>  for (i=0; i&lt;$2; i++)
<a name="numpy.i-1803"></a>  {
<a name="numpy.i-1804"></a>    temp_array = obj_to_array_no_conversion(PySequence_GetItem($input,i), DATA_TYPECODE);
<a name="numpy.i-1805"></a>
<a name="numpy.i-1806"></a>    /* the new array must be stored so that it can be destroyed in freearg */
<a name="numpy.i-1807"></a>    object_array[i] = temp_array;
<a name="numpy.i-1808"></a>
<a name="numpy.i-1809"></a>    if ( !temp_array || !require_dimensions(temp_array, 3) ||
<a name="numpy.i-1810"></a>      !require_contiguous(temp_array) ||
<a name="numpy.i-1811"></a>      !require_native(temp_array) ||
<a name="numpy.i-1812"></a>      !PyArray_EquivTypenums(array_type(temp_array), DATA_TYPECODE)
<a name="numpy.i-1813"></a>    ) SWIG_fail;
<a name="numpy.i-1814"></a>
<a name="numpy.i-1815"></a>    /* store the size of the first array in the list, then use that for comparison. */
<a name="numpy.i-1816"></a>    if (i == 0)
<a name="numpy.i-1817"></a>    {
<a name="numpy.i-1818"></a>      size[0] = array_size(temp_array,0);
<a name="numpy.i-1819"></a>      size[1] = array_size(temp_array,1);
<a name="numpy.i-1820"></a>      size[2] = array_size(temp_array,2);
<a name="numpy.i-1821"></a>    }
<a name="numpy.i-1822"></a>
<a name="numpy.i-1823"></a>    if (!require_size(temp_array, size, 3)) SWIG_fail;
<a name="numpy.i-1824"></a>
<a name="numpy.i-1825"></a>    array[i] = (DATA_TYPE*) array_data(temp_array);
<a name="numpy.i-1826"></a>  }
<a name="numpy.i-1827"></a>
<a name="numpy.i-1828"></a>  $1 = (DATA_TYPE**) array;
<a name="numpy.i-1829"></a>  $3 = (DIM_TYPE) size[0];
<a name="numpy.i-1830"></a>  $4 = (DIM_TYPE) size[1];
<a name="numpy.i-1831"></a>  $5 = (DIM_TYPE) size[2];
<a name="numpy.i-1832"></a>}
<a name="numpy.i-1833"></a>%typemap(freearg)
<a name="numpy.i-1834"></a>  (DATA_TYPE** INPLACE_ARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1835"></a>{
<a name="numpy.i-1836"></a>  if (array$argnum!=NULL) free(array$argnum);
<a name="numpy.i-1837"></a>  if (object_array$argnum!=NULL) free(object_array$argnum);
<a name="numpy.i-1838"></a>}
<a name="numpy.i-1839"></a>
<a name="numpy.i-1840"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4,
<a name="numpy.i-1841"></a> *                    DATA_TYPE* INPLACE_ARRAY4)
<a name="numpy.i-1842"></a> */
<a name="numpy.i-1843"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1844"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1845"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_ARRAY4)
<a name="numpy.i-1846"></a>{
<a name="numpy.i-1847"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1848"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1849"></a>}
<a name="numpy.i-1850"></a>%typemap(in,
<a name="numpy.i-1851"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1852"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_ARRAY4)
<a name="numpy.i-1853"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1854"></a>{
<a name="numpy.i-1855"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1856"></a>  if (!array || !require_dimensions(array,4) || !require_contiguous(array)
<a name="numpy.i-1857"></a>      || !require_native(array)) SWIG_fail;
<a name="numpy.i-1858"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1859"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1860"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1861"></a>  $4 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1862"></a>  $5 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1863"></a>}
<a name="numpy.i-1864"></a>
<a name="numpy.i-1865"></a>/* Typemap suite for (DATA_TYPE* INPLACE_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2,
<a name="numpy.i-1866"></a> *                    DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1867"></a> */
<a name="numpy.i-1868"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1869"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1870"></a>  (DATA_TYPE* INPLACE_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1871"></a>{
<a name="numpy.i-1872"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1873"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1874"></a>}
<a name="numpy.i-1875"></a>%typemap(in,
<a name="numpy.i-1876"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1877"></a>  (DATA_TYPE* INPLACE_FARRAY4, DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4)
<a name="numpy.i-1878"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1879"></a>{
<a name="numpy.i-1880"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1881"></a>  if (!array || !require_dimensions(array,4) || !require_contiguous(array) ||
<a name="numpy.i-1882"></a>      !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1883"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1884"></a>  $2 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1885"></a>  $3 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1886"></a>  $4 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1887"></a>  $5 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1888"></a>}
<a name="numpy.i-1889"></a>
<a name="numpy.i-1890"></a>/* Typemap suite for (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3,
<a name="numpy.i-1891"></a> *                    DATA_TYPE* INPLACE_FARRAY4)
<a name="numpy.i-1892"></a> */
<a name="numpy.i-1893"></a>%typecheck(SWIG_TYPECHECK_DOUBLE_ARRAY,
<a name="numpy.i-1894"></a>           fragment="NumPy_Macros")
<a name="numpy.i-1895"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_FARRAY4)
<a name="numpy.i-1896"></a>{
<a name="numpy.i-1897"></a>  $1 = is_array($input) &amp;&amp; PyArray_EquivTypenums(array_type($input),
<a name="numpy.i-1898"></a>                                                 DATA_TYPECODE);
<a name="numpy.i-1899"></a>}
<a name="numpy.i-1900"></a>%typemap(in,
<a name="numpy.i-1901"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1902"></a>  (DIM_TYPE DIM1, DIM_TYPE DIM2, DIM_TYPE DIM3, DIM_TYPE DIM4, DATA_TYPE* INPLACE_FARRAY4)
<a name="numpy.i-1903"></a>  (PyArrayObject* array=NULL)
<a name="numpy.i-1904"></a>{
<a name="numpy.i-1905"></a>  array = obj_to_array_no_conversion($input, DATA_TYPECODE);
<a name="numpy.i-1906"></a>  if (!array || !require_dimensions(array,4) || !require_contiguous(array)
<a name="numpy.i-1907"></a>      || !require_native(array) || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-1908"></a>  $1 = (DIM_TYPE) array_size(array,0);
<a name="numpy.i-1909"></a>  $2 = (DIM_TYPE) array_size(array,1);
<a name="numpy.i-1910"></a>  $3 = (DIM_TYPE) array_size(array,2);
<a name="numpy.i-1911"></a>  $4 = (DIM_TYPE) array_size(array,3);
<a name="numpy.i-1912"></a>  $5 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1913"></a>}
<a name="numpy.i-1914"></a>
<a name="numpy.i-1915"></a>/*************************/
<a name="numpy.i-1916"></a>/* Argout Array Typemaps */
<a name="numpy.i-1917"></a>/*************************/
<a name="numpy.i-1918"></a>
<a name="numpy.i-1919"></a>/* Typemap suite for (DATA_TYPE ARGOUT_ARRAY1[ANY])
<a name="numpy.i-1920"></a> */
<a name="numpy.i-1921"></a>%typemap(in,numinputs=0,
<a name="numpy.i-1922"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Macros")
<a name="numpy.i-1923"></a>  (DATA_TYPE ARGOUT_ARRAY1[ANY])
<a name="numpy.i-1924"></a>  (PyObject* array = NULL)
<a name="numpy.i-1925"></a>{
<a name="numpy.i-1926"></a>  npy_intp dims[1] = { $1_dim0 };
<a name="numpy.i-1927"></a>  array = PyArray_SimpleNew(1, dims, DATA_TYPECODE);
<a name="numpy.i-1928"></a>  if (!array) SWIG_fail;
<a name="numpy.i-1929"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-1930"></a>}
<a name="numpy.i-1931"></a>%typemap(argout)
<a name="numpy.i-1932"></a>  (DATA_TYPE ARGOUT_ARRAY1[ANY])
<a name="numpy.i-1933"></a>{
<a name="numpy.i-1934"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-1935"></a>}
<a name="numpy.i-1936"></a>
<a name="numpy.i-1937"></a>/* Typemap suite for (DATA_TYPE* ARGOUT_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1938"></a> */
<a name="numpy.i-1939"></a>%typemap(in,numinputs=1,
<a name="numpy.i-1940"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1941"></a>  (DATA_TYPE* ARGOUT_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1942"></a>  (PyObject* array = NULL)
<a name="numpy.i-1943"></a>{
<a name="numpy.i-1944"></a>  npy_intp dims[1];
<a name="numpy.i-1945"></a>  if (!PyInt_Check($input))
<a name="numpy.i-1946"></a>  {
<a name="numpy.i-1947"></a>    const char* typestring = pytype_string($input);
<a name="numpy.i-1948"></a>    PyErr_Format(PyExc_TypeError,
<a name="numpy.i-1949"></a>                 "Int dimension expected.  '%s' given.",
<a name="numpy.i-1950"></a>                 typestring);
<a name="numpy.i-1951"></a>    SWIG_fail;
<a name="numpy.i-1952"></a>  }
<a name="numpy.i-1953"></a>  $2 = (DIM_TYPE) PyInt_AsLong($input);
<a name="numpy.i-1954"></a>  dims[0] = (npy_intp) $2;
<a name="numpy.i-1955"></a>  array = PyArray_SimpleNew(1, dims, DATA_TYPECODE);
<a name="numpy.i-1956"></a>  if (!array) SWIG_fail;
<a name="numpy.i-1957"></a>  $1 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1958"></a>}
<a name="numpy.i-1959"></a>%typemap(argout)
<a name="numpy.i-1960"></a>  (DATA_TYPE* ARGOUT_ARRAY1, DIM_TYPE DIM1)
<a name="numpy.i-1961"></a>{
<a name="numpy.i-1962"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-1963"></a>}
<a name="numpy.i-1964"></a>
<a name="numpy.i-1965"></a>/* Typemap suite for (DIM_TYPE DIM1, DATA_TYPE* ARGOUT_ARRAY1)
<a name="numpy.i-1966"></a> */
<a name="numpy.i-1967"></a>%typemap(in,numinputs=1,
<a name="numpy.i-1968"></a>         fragment="NumPy_Fragments")
<a name="numpy.i-1969"></a>  (DIM_TYPE DIM1, DATA_TYPE* ARGOUT_ARRAY1)
<a name="numpy.i-1970"></a>  (PyObject* array = NULL)
<a name="numpy.i-1971"></a>{
<a name="numpy.i-1972"></a>  npy_intp dims[1];
<a name="numpy.i-1973"></a>  if (!PyInt_Check($input))
<a name="numpy.i-1974"></a>  {
<a name="numpy.i-1975"></a>    const char* typestring = pytype_string($input);
<a name="numpy.i-1976"></a>    PyErr_Format(PyExc_TypeError,
<a name="numpy.i-1977"></a>                 "Int dimension expected.  '%s' given.",
<a name="numpy.i-1978"></a>                 typestring);
<a name="numpy.i-1979"></a>    SWIG_fail;
<a name="numpy.i-1980"></a>  }
<a name="numpy.i-1981"></a>  $1 = (DIM_TYPE) PyInt_AsLong($input);
<a name="numpy.i-1982"></a>  dims[0] = (npy_intp) $1;
<a name="numpy.i-1983"></a>  array = PyArray_SimpleNew(1, dims, DATA_TYPECODE);
<a name="numpy.i-1984"></a>  if (!array) SWIG_fail;
<a name="numpy.i-1985"></a>  $2 = (DATA_TYPE*) array_data(array);
<a name="numpy.i-1986"></a>}
<a name="numpy.i-1987"></a>%typemap(argout)
<a name="numpy.i-1988"></a>  (DIM_TYPE DIM1, DATA_TYPE* ARGOUT_ARRAY1)
<a name="numpy.i-1989"></a>{
<a name="numpy.i-1990"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-1991"></a>}
<a name="numpy.i-1992"></a>
<a name="numpy.i-1993"></a>/* Typemap suite for (DATA_TYPE ARGOUT_ARRAY2[ANY][ANY])
<a name="numpy.i-1994"></a> */
<a name="numpy.i-1995"></a>%typemap(in,numinputs=0,
<a name="numpy.i-1996"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Macros")
<a name="numpy.i-1997"></a>  (DATA_TYPE ARGOUT_ARRAY2[ANY][ANY])
<a name="numpy.i-1998"></a>  (PyObject* array = NULL)
<a name="numpy.i-1999"></a>{
<a name="numpy.i-2000"></a>  npy_intp dims[2] = { $1_dim0, $1_dim1 };
<a name="numpy.i-2001"></a>  array = PyArray_SimpleNew(2, dims, DATA_TYPECODE);
<a name="numpy.i-2002"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2003"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-2004"></a>}
<a name="numpy.i-2005"></a>%typemap(argout)
<a name="numpy.i-2006"></a>  (DATA_TYPE ARGOUT_ARRAY2[ANY][ANY])
<a name="numpy.i-2007"></a>{
<a name="numpy.i-2008"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-2009"></a>}
<a name="numpy.i-2010"></a>
<a name="numpy.i-2011"></a>/* Typemap suite for (DATA_TYPE ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-2012"></a> */
<a name="numpy.i-2013"></a>%typemap(in,numinputs=0,
<a name="numpy.i-2014"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Macros")
<a name="numpy.i-2015"></a>  (DATA_TYPE ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-2016"></a>  (PyObject* array = NULL)
<a name="numpy.i-2017"></a>{
<a name="numpy.i-2018"></a>  npy_intp dims[3] = { $1_dim0, $1_dim1, $1_dim2 };
<a name="numpy.i-2019"></a>  array = PyArray_SimpleNew(3, dims, DATA_TYPECODE);
<a name="numpy.i-2020"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2021"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-2022"></a>}
<a name="numpy.i-2023"></a>%typemap(argout)
<a name="numpy.i-2024"></a>  (DATA_TYPE ARGOUT_ARRAY3[ANY][ANY][ANY])
<a name="numpy.i-2025"></a>{
<a name="numpy.i-2026"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-2027"></a>}
<a name="numpy.i-2028"></a>
<a name="numpy.i-2029"></a>/* Typemap suite for (DATA_TYPE ARGOUT_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-2030"></a> */
<a name="numpy.i-2031"></a>%typemap(in,numinputs=0,
<a name="numpy.i-2032"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Macros")
<a name="numpy.i-2033"></a>  (DATA_TYPE ARGOUT_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-2034"></a>  (PyObject* array = NULL)
<a name="numpy.i-2035"></a>{
<a name="numpy.i-2036"></a>  npy_intp dims[4] = { $1_dim0, $1_dim1, $1_dim2, $1_dim3 };
<a name="numpy.i-2037"></a>  array = PyArray_SimpleNew(4, dims, DATA_TYPECODE);
<a name="numpy.i-2038"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2039"></a>  $1 = ($1_ltype) array_data(array);
<a name="numpy.i-2040"></a>}
<a name="numpy.i-2041"></a>%typemap(argout)
<a name="numpy.i-2042"></a>  (DATA_TYPE ARGOUT_ARRAY4[ANY][ANY][ANY][ANY])
<a name="numpy.i-2043"></a>{
<a name="numpy.i-2044"></a>  $result = SWIG_Python_AppendOutput($result,(PyObject*)array$argnum);
<a name="numpy.i-2045"></a>}
<a name="numpy.i-2046"></a>
<a name="numpy.i-2047"></a>/*****************************/
<a name="numpy.i-2048"></a>/* Argoutview Array Typemaps */
<a name="numpy.i-2049"></a>/*****************************/
<a name="numpy.i-2050"></a>
<a name="numpy.i-2051"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-2052"></a> */
<a name="numpy.i-2053"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2054"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY1, DIM_TYPE* DIM1    )
<a name="numpy.i-2055"></a>  (DATA_TYPE*  data_temp = NULL , DIM_TYPE  dim_temp)
<a name="numpy.i-2056"></a>{
<a name="numpy.i-2057"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2058"></a>  $2 = &amp;dim_temp;
<a name="numpy.i-2059"></a>}
<a name="numpy.i-2060"></a>%typemap(argout,
<a name="numpy.i-2061"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2062"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-2063"></a>{
<a name="numpy.i-2064"></a>  npy_intp dims[1] = { *$2 };
<a name="numpy.i-2065"></a>  PyObject* obj = PyArray_SimpleNewFromData(1, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2066"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2067"></a>
<a name="numpy.i-2068"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2069"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2070"></a>}
<a name="numpy.i-2071"></a>
<a name="numpy.i-2072"></a>/* Typemap suite for (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEW_ARRAY1)
<a name="numpy.i-2073"></a> */
<a name="numpy.i-2074"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2075"></a>  (DIM_TYPE* DIM1    , DATA_TYPE** ARGOUTVIEW_ARRAY1)
<a name="numpy.i-2076"></a>  (DIM_TYPE  dim_temp, DATA_TYPE*  data_temp = NULL )
<a name="numpy.i-2077"></a>{
<a name="numpy.i-2078"></a>  $1 = &amp;dim_temp;
<a name="numpy.i-2079"></a>  $2 = &amp;data_temp;
<a name="numpy.i-2080"></a>}
<a name="numpy.i-2081"></a>%typemap(argout,
<a name="numpy.i-2082"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2083"></a>  (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEW_ARRAY1)
<a name="numpy.i-2084"></a>{
<a name="numpy.i-2085"></a>  npy_intp dims[1] = { *$1 };
<a name="numpy.i-2086"></a>  PyObject* obj = PyArray_SimpleNewFromData(1, dims, DATA_TYPECODE, (void*)(*$2));
<a name="numpy.i-2087"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2088"></a>
<a name="numpy.i-2089"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2090"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2091"></a>}
<a name="numpy.i-2092"></a>
<a name="numpy.i-2093"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2094"></a> */
<a name="numpy.i-2095"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2096"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY2, DIM_TYPE* DIM1     , DIM_TYPE* DIM2     )
<a name="numpy.i-2097"></a>  (DATA_TYPE*  data_temp = NULL , DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp)
<a name="numpy.i-2098"></a>{
<a name="numpy.i-2099"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2100"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2101"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2102"></a>}
<a name="numpy.i-2103"></a>%typemap(argout,
<a name="numpy.i-2104"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2105"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2106"></a>{
<a name="numpy.i-2107"></a>  npy_intp dims[2] = { *$2, *$3 };
<a name="numpy.i-2108"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2109"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2110"></a>
<a name="numpy.i-2111"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2112"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2113"></a>}
<a name="numpy.i-2114"></a>
<a name="numpy.i-2115"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_ARRAY2)
<a name="numpy.i-2116"></a> */
<a name="numpy.i-2117"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2118"></a>  (DIM_TYPE* DIM1     , DIM_TYPE* DIM2     , DATA_TYPE** ARGOUTVIEW_ARRAY2)
<a name="numpy.i-2119"></a>  (DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp, DATA_TYPE*  data_temp = NULL )
<a name="numpy.i-2120"></a>{
<a name="numpy.i-2121"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2122"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2123"></a>  $3 = &amp;data_temp;
<a name="numpy.i-2124"></a>}
<a name="numpy.i-2125"></a>%typemap(argout,
<a name="numpy.i-2126"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2127"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_ARRAY2)
<a name="numpy.i-2128"></a>{
<a name="numpy.i-2129"></a>  npy_intp dims[2] = { *$1, *$2 };
<a name="numpy.i-2130"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$3));
<a name="numpy.i-2131"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2132"></a>
<a name="numpy.i-2133"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2134"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2135"></a>}
<a name="numpy.i-2136"></a>
<a name="numpy.i-2137"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2138"></a> */
<a name="numpy.i-2139"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2140"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY2, DIM_TYPE* DIM1     , DIM_TYPE* DIM2     )
<a name="numpy.i-2141"></a>  (DATA_TYPE*  data_temp = NULL  , DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp)
<a name="numpy.i-2142"></a>{
<a name="numpy.i-2143"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2144"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2145"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2146"></a>}
<a name="numpy.i-2147"></a>%typemap(argout,
<a name="numpy.i-2148"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2149"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2150"></a>{
<a name="numpy.i-2151"></a>  npy_intp dims[2] = { *$2, *$3 };
<a name="numpy.i-2152"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2153"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2154"></a>
<a name="numpy.i-2155"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2156"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2157"></a>}
<a name="numpy.i-2158"></a>
<a name="numpy.i-2159"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_FARRAY2)
<a name="numpy.i-2160"></a> */
<a name="numpy.i-2161"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2162"></a>  (DIM_TYPE* DIM1     , DIM_TYPE* DIM2     , DATA_TYPE** ARGOUTVIEW_FARRAY2)
<a name="numpy.i-2163"></a>  (DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp, DATA_TYPE*  data_temp = NULL  )
<a name="numpy.i-2164"></a>{
<a name="numpy.i-2165"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2166"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2167"></a>  $3 = &amp;data_temp;
<a name="numpy.i-2168"></a>}
<a name="numpy.i-2169"></a>%typemap(argout,
<a name="numpy.i-2170"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2171"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEW_FARRAY2)
<a name="numpy.i-2172"></a>{
<a name="numpy.i-2173"></a>  npy_intp dims[2] = { *$1, *$2 };
<a name="numpy.i-2174"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$3));
<a name="numpy.i-2175"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2176"></a>
<a name="numpy.i-2177"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2178"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2179"></a>}
<a name="numpy.i-2180"></a>
<a name="numpy.i-2181"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2182"></a>                      DIM_TYPE* DIM3)
<a name="numpy.i-2183"></a> */
<a name="numpy.i-2184"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2185"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY3, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    )
<a name="numpy.i-2186"></a>  (DATA_TYPE* data_temp = NULL  , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp)
<a name="numpy.i-2187"></a>{
<a name="numpy.i-2188"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2189"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2190"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2191"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2192"></a>}
<a name="numpy.i-2193"></a>%typemap(argout,
<a name="numpy.i-2194"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2195"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-2196"></a>{
<a name="numpy.i-2197"></a>  npy_intp dims[3] = { *$2, *$3, *$4 };
<a name="numpy.i-2198"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2199"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2200"></a>
<a name="numpy.i-2201"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2202"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2203"></a>}
<a name="numpy.i-2204"></a>
<a name="numpy.i-2205"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3,
<a name="numpy.i-2206"></a>                      DATA_TYPE** ARGOUTVIEW_ARRAY3)
<a name="numpy.i-2207"></a> */
<a name="numpy.i-2208"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2209"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEW_ARRAY3)
<a name="numpy.i-2210"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DATA_TYPE* data_temp = NULL)
<a name="numpy.i-2211"></a>{
<a name="numpy.i-2212"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2213"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2214"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2215"></a>  $4 = &amp;data_temp;
<a name="numpy.i-2216"></a>}
<a name="numpy.i-2217"></a>%typemap(argout,
<a name="numpy.i-2218"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2219"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEW_ARRAY3)
<a name="numpy.i-2220"></a>{
<a name="numpy.i-2221"></a>  npy_intp dims[3] = { *$1, *$2, *$3 };
<a name="numpy.i-2222"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$4));
<a name="numpy.i-2223"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2224"></a>
<a name="numpy.i-2225"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2226"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2227"></a>}
<a name="numpy.i-2228"></a>
<a name="numpy.i-2229"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2230"></a>                      DIM_TYPE* DIM3)
<a name="numpy.i-2231"></a> */
<a name="numpy.i-2232"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2233"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY3, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    )
<a name="numpy.i-2234"></a>  (DATA_TYPE* data_temp = NULL   , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp)
<a name="numpy.i-2235"></a>{
<a name="numpy.i-2236"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2237"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2238"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2239"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2240"></a>}
<a name="numpy.i-2241"></a>%typemap(argout,
<a name="numpy.i-2242"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2243"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-2244"></a>{
<a name="numpy.i-2245"></a>  npy_intp dims[3] = { *$2, *$3, *$4 };
<a name="numpy.i-2246"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2247"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2248"></a>
<a name="numpy.i-2249"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2250"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2251"></a>}
<a name="numpy.i-2252"></a>
<a name="numpy.i-2253"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3,
<a name="numpy.i-2254"></a>                      DATA_TYPE** ARGOUTVIEW_FARRAY3)
<a name="numpy.i-2255"></a> */
<a name="numpy.i-2256"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2257"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DATA_TYPE** ARGOUTVIEW_FARRAY3)
<a name="numpy.i-2258"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DATA_TYPE* data_temp = NULL   )
<a name="numpy.i-2259"></a>{
<a name="numpy.i-2260"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2261"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2262"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2263"></a>  $4 = &amp;data_temp;
<a name="numpy.i-2264"></a>}
<a name="numpy.i-2265"></a>%typemap(argout,
<a name="numpy.i-2266"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2267"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEW_FARRAY3)
<a name="numpy.i-2268"></a>{
<a name="numpy.i-2269"></a>  npy_intp dims[3] = { *$1, *$2, *$3 };
<a name="numpy.i-2270"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$4));
<a name="numpy.i-2271"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2272"></a>
<a name="numpy.i-2273"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2274"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2275"></a>}
<a name="numpy.i-2276"></a>
<a name="numpy.i-2277"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2278"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2279"></a> */
<a name="numpy.i-2280"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2281"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2282"></a>  (DATA_TYPE* data_temp = NULL  , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2283"></a>{
<a name="numpy.i-2284"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2285"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2286"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2287"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2288"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2289"></a>}
<a name="numpy.i-2290"></a>%typemap(argout,
<a name="numpy.i-2291"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2292"></a>  (DATA_TYPE** ARGOUTVIEW_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2293"></a>{
<a name="numpy.i-2294"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2295"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2296"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2297"></a>
<a name="numpy.i-2298"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2299"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2300"></a>}
<a name="numpy.i-2301"></a>
<a name="numpy.i-2302"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-2303"></a>                      DATA_TYPE** ARGOUTVIEW_ARRAY4)
<a name="numpy.i-2304"></a> */
<a name="numpy.i-2305"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2306"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEW_ARRAY4)
<a name="numpy.i-2307"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL  )
<a name="numpy.i-2308"></a>{
<a name="numpy.i-2309"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2310"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2311"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2312"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-2313"></a>  $5 = &amp;data_temp;
<a name="numpy.i-2314"></a>}
<a name="numpy.i-2315"></a>%typemap(argout,
<a name="numpy.i-2316"></a>         fragment="NumPy_Backward_Compatibility")
<a name="numpy.i-2317"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEW_ARRAY4)
<a name="numpy.i-2318"></a>{
<a name="numpy.i-2319"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-2320"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-2321"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2322"></a>
<a name="numpy.i-2323"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2324"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2325"></a>}
<a name="numpy.i-2326"></a>
<a name="numpy.i-2327"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEW_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2328"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2329"></a> */
<a name="numpy.i-2330"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2331"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2332"></a>  (DATA_TYPE* data_temp = NULL   , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2333"></a>{
<a name="numpy.i-2334"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2335"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2336"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2337"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2338"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2339"></a>}
<a name="numpy.i-2340"></a>%typemap(argout,
<a name="numpy.i-2341"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2342"></a>  (DATA_TYPE** ARGOUTVIEW_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2343"></a>{
<a name="numpy.i-2344"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2345"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2346"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2347"></a>
<a name="numpy.i-2348"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2349"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2350"></a>}
<a name="numpy.i-2351"></a>
<a name="numpy.i-2352"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-2353"></a>                      DATA_TYPE** ARGOUTVIEW_FARRAY4)
<a name="numpy.i-2354"></a> */
<a name="numpy.i-2355"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2356"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEW_FARRAY4)
<a name="numpy.i-2357"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL   )
<a name="numpy.i-2358"></a>{
<a name="numpy.i-2359"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2360"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2361"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2362"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-2363"></a>  $5 = &amp;data_temp;
<a name="numpy.i-2364"></a>}
<a name="numpy.i-2365"></a>%typemap(argout,
<a name="numpy.i-2366"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements")
<a name="numpy.i-2367"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEW_FARRAY4)
<a name="numpy.i-2368"></a>{
<a name="numpy.i-2369"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-2370"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-2371"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2372"></a>
<a name="numpy.i-2373"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2374"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2375"></a>}
<a name="numpy.i-2376"></a>
<a name="numpy.i-2377"></a>/*************************************/
<a name="numpy.i-2378"></a>/* Managed Argoutview Array Typemaps */
<a name="numpy.i-2379"></a>/*************************************/
<a name="numpy.i-2380"></a>
<a name="numpy.i-2381"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-2382"></a> */
<a name="numpy.i-2383"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2384"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY1, DIM_TYPE* DIM1    )
<a name="numpy.i-2385"></a>  (DATA_TYPE*  data_temp = NULL  , DIM_TYPE  dim_temp)
<a name="numpy.i-2386"></a>{
<a name="numpy.i-2387"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2388"></a>  $2 = &amp;dim_temp;
<a name="numpy.i-2389"></a>}
<a name="numpy.i-2390"></a>%typemap(argout,
<a name="numpy.i-2391"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2392"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY1, DIM_TYPE* DIM1)
<a name="numpy.i-2393"></a>{
<a name="numpy.i-2394"></a>  npy_intp dims[1] = { *$2 };
<a name="numpy.i-2395"></a>  PyObject* obj = PyArray_SimpleNewFromData(1, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2396"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2397"></a>
<a name="numpy.i-2398"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2399"></a>
<a name="numpy.i-2400"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2401"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2402"></a>%#else
<a name="numpy.i-2403"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2404"></a>%#endif
<a name="numpy.i-2405"></a>
<a name="numpy.i-2406"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2407"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2408"></a>%#else
<a name="numpy.i-2409"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2410"></a>%#endif
<a name="numpy.i-2411"></a>
<a name="numpy.i-2412"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2413"></a>}
<a name="numpy.i-2414"></a>
<a name="numpy.i-2415"></a>/* Typemap suite for (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEWM_ARRAY1)
<a name="numpy.i-2416"></a> */
<a name="numpy.i-2417"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2418"></a>  (DIM_TYPE* DIM1    , DATA_TYPE** ARGOUTVIEWM_ARRAY1)
<a name="numpy.i-2419"></a>  (DIM_TYPE  dim_temp, DATA_TYPE*  data_temp = NULL  )
<a name="numpy.i-2420"></a>{
<a name="numpy.i-2421"></a>  $1 = &amp;dim_temp;
<a name="numpy.i-2422"></a>  $2 = &amp;data_temp;
<a name="numpy.i-2423"></a>}
<a name="numpy.i-2424"></a>%typemap(argout,
<a name="numpy.i-2425"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2426"></a>  (DIM_TYPE* DIM1, DATA_TYPE** ARGOUTVIEWM_ARRAY1)
<a name="numpy.i-2427"></a>{
<a name="numpy.i-2428"></a>  npy_intp dims[1] = { *$1 };
<a name="numpy.i-2429"></a>  PyObject* obj = PyArray_SimpleNewFromData(1, dims, DATA_TYPECODE, (void*)(*$2));
<a name="numpy.i-2430"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2431"></a>
<a name="numpy.i-2432"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2433"></a>
<a name="numpy.i-2434"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2435"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2436"></a>%#else
<a name="numpy.i-2437"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2438"></a>%#endif
<a name="numpy.i-2439"></a>
<a name="numpy.i-2440"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2441"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2442"></a>%#else
<a name="numpy.i-2443"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2444"></a>%#endif
<a name="numpy.i-2445"></a>
<a name="numpy.i-2446"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2447"></a>}
<a name="numpy.i-2448"></a>
<a name="numpy.i-2449"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2450"></a> */
<a name="numpy.i-2451"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2452"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY2, DIM_TYPE* DIM1     , DIM_TYPE* DIM2     )
<a name="numpy.i-2453"></a>  (DATA_TYPE*  data_temp = NULL  , DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp)
<a name="numpy.i-2454"></a>{
<a name="numpy.i-2455"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2456"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2457"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2458"></a>}
<a name="numpy.i-2459"></a>%typemap(argout,
<a name="numpy.i-2460"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2461"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2462"></a>{
<a name="numpy.i-2463"></a>  npy_intp dims[2] = { *$2, *$3 };
<a name="numpy.i-2464"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2465"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2466"></a>
<a name="numpy.i-2467"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2468"></a>
<a name="numpy.i-2469"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2470"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2471"></a>%#else
<a name="numpy.i-2472"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2473"></a>%#endif
<a name="numpy.i-2474"></a>
<a name="numpy.i-2475"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2476"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2477"></a>%#else
<a name="numpy.i-2478"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2479"></a>%#endif
<a name="numpy.i-2480"></a>
<a name="numpy.i-2481"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2482"></a>}
<a name="numpy.i-2483"></a>
<a name="numpy.i-2484"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_ARRAY2)
<a name="numpy.i-2485"></a> */
<a name="numpy.i-2486"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2487"></a>  (DIM_TYPE* DIM1     , DIM_TYPE* DIM2     , DATA_TYPE** ARGOUTVIEWM_ARRAY2)
<a name="numpy.i-2488"></a>  (DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp, DATA_TYPE*  data_temp = NULL  )
<a name="numpy.i-2489"></a>{
<a name="numpy.i-2490"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2491"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2492"></a>  $3 = &amp;data_temp;
<a name="numpy.i-2493"></a>}
<a name="numpy.i-2494"></a>%typemap(argout,
<a name="numpy.i-2495"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2496"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_ARRAY2)
<a name="numpy.i-2497"></a>{
<a name="numpy.i-2498"></a>  npy_intp dims[2] = { *$1, *$2 };
<a name="numpy.i-2499"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$3));
<a name="numpy.i-2500"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2501"></a>
<a name="numpy.i-2502"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2503"></a>
<a name="numpy.i-2504"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2505"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2506"></a>%#else
<a name="numpy.i-2507"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2508"></a>%#endif
<a name="numpy.i-2509"></a>
<a name="numpy.i-2510"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2511"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2512"></a>%#else
<a name="numpy.i-2513"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2514"></a>%#endif
<a name="numpy.i-2515"></a>
<a name="numpy.i-2516"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2517"></a>}
<a name="numpy.i-2518"></a>
<a name="numpy.i-2519"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2520"></a> */
<a name="numpy.i-2521"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2522"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY2, DIM_TYPE* DIM1     , DIM_TYPE* DIM2     )
<a name="numpy.i-2523"></a>  (DATA_TYPE*  data_temp = NULL   , DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp)
<a name="numpy.i-2524"></a>{
<a name="numpy.i-2525"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2526"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2527"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2528"></a>}
<a name="numpy.i-2529"></a>%typemap(argout,
<a name="numpy.i-2530"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2531"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY2, DIM_TYPE* DIM1, DIM_TYPE* DIM2)
<a name="numpy.i-2532"></a>{
<a name="numpy.i-2533"></a>  npy_intp dims[2] = { *$2, *$3 };
<a name="numpy.i-2534"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2535"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2536"></a>
<a name="numpy.i-2537"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2538"></a>
<a name="numpy.i-2539"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2540"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2541"></a>%#else
<a name="numpy.i-2542"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2543"></a>%#endif
<a name="numpy.i-2544"></a>
<a name="numpy.i-2545"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2546"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2547"></a>%#else
<a name="numpy.i-2548"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2549"></a>%#endif
<a name="numpy.i-2550"></a>
<a name="numpy.i-2551"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2552"></a>}
<a name="numpy.i-2553"></a>
<a name="numpy.i-2554"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_FARRAY2)
<a name="numpy.i-2555"></a> */
<a name="numpy.i-2556"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2557"></a>  (DIM_TYPE* DIM1     , DIM_TYPE* DIM2     , DATA_TYPE** ARGOUTVIEWM_FARRAY2)
<a name="numpy.i-2558"></a>  (DIM_TYPE  dim1_temp, DIM_TYPE  dim2_temp, DATA_TYPE*  data_temp = NULL   )
<a name="numpy.i-2559"></a>{
<a name="numpy.i-2560"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2561"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2562"></a>  $3 = &amp;data_temp;
<a name="numpy.i-2563"></a>}
<a name="numpy.i-2564"></a>%typemap(argout,
<a name="numpy.i-2565"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2566"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DATA_TYPE** ARGOUTVIEWM_FARRAY2)
<a name="numpy.i-2567"></a>{
<a name="numpy.i-2568"></a>  npy_intp dims[2] = { *$1, *$2 };
<a name="numpy.i-2569"></a>  PyObject* obj = PyArray_SimpleNewFromData(2, dims, DATA_TYPECODE, (void*)(*$3));
<a name="numpy.i-2570"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2571"></a>
<a name="numpy.i-2572"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2573"></a>
<a name="numpy.i-2574"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2575"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2576"></a>%#else
<a name="numpy.i-2577"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2578"></a>%#endif
<a name="numpy.i-2579"></a>
<a name="numpy.i-2580"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2581"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2582"></a>%#else
<a name="numpy.i-2583"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2584"></a>%#endif
<a name="numpy.i-2585"></a>
<a name="numpy.i-2586"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2587"></a>}
<a name="numpy.i-2588"></a>
<a name="numpy.i-2589"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2590"></a>                      DIM_TYPE* DIM3)
<a name="numpy.i-2591"></a> */
<a name="numpy.i-2592"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2593"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY3, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    )
<a name="numpy.i-2594"></a>  (DATA_TYPE* data_temp = NULL   , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp)
<a name="numpy.i-2595"></a>{
<a name="numpy.i-2596"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2597"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2598"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2599"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2600"></a>}
<a name="numpy.i-2601"></a>%typemap(argout,
<a name="numpy.i-2602"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2603"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-2604"></a>{
<a name="numpy.i-2605"></a>  npy_intp dims[3] = { *$2, *$3, *$4 };
<a name="numpy.i-2606"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2607"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2608"></a>
<a name="numpy.i-2609"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2610"></a>
<a name="numpy.i-2611"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2612"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2613"></a>%#else
<a name="numpy.i-2614"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2615"></a>%#endif
<a name="numpy.i-2616"></a>
<a name="numpy.i-2617"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2618"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2619"></a>%#else
<a name="numpy.i-2620"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2621"></a>%#endif
<a name="numpy.i-2622"></a>
<a name="numpy.i-2623"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2624"></a>}
<a name="numpy.i-2625"></a>
<a name="numpy.i-2626"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3,
<a name="numpy.i-2627"></a>                      DATA_TYPE** ARGOUTVIEWM_ARRAY3)
<a name="numpy.i-2628"></a> */
<a name="numpy.i-2629"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2630"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DATA_TYPE** ARGOUTVIEWM_ARRAY3)
<a name="numpy.i-2631"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DATA_TYPE* data_temp = NULL   )
<a name="numpy.i-2632"></a>{
<a name="numpy.i-2633"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2634"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2635"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2636"></a>  $4 = &amp;data_temp;
<a name="numpy.i-2637"></a>}
<a name="numpy.i-2638"></a>%typemap(argout,
<a name="numpy.i-2639"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2640"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEWM_ARRAY3)
<a name="numpy.i-2641"></a>{
<a name="numpy.i-2642"></a>  npy_intp dims[3] = { *$1, *$2, *$3 };
<a name="numpy.i-2643"></a>  PyObject* obj= PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$4));
<a name="numpy.i-2644"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2645"></a>
<a name="numpy.i-2646"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2647"></a>
<a name="numpy.i-2648"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2649"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2650"></a>%#else
<a name="numpy.i-2651"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2652"></a>%#endif
<a name="numpy.i-2653"></a>
<a name="numpy.i-2654"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2655"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2656"></a>%#else
<a name="numpy.i-2657"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2658"></a>%#endif
<a name="numpy.i-2659"></a>
<a name="numpy.i-2660"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2661"></a>}
<a name="numpy.i-2662"></a>
<a name="numpy.i-2663"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2664"></a>                      DIM_TYPE* DIM3)
<a name="numpy.i-2665"></a> */
<a name="numpy.i-2666"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2667"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY3, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    )
<a name="numpy.i-2668"></a>  (DATA_TYPE* data_temp = NULL    , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp)
<a name="numpy.i-2669"></a>{
<a name="numpy.i-2670"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2671"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2672"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2673"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2674"></a>}
<a name="numpy.i-2675"></a>%typemap(argout,
<a name="numpy.i-2676"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2677"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY3, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-2678"></a>{
<a name="numpy.i-2679"></a>  npy_intp dims[3] = { *$2, *$3, *$4 };
<a name="numpy.i-2680"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2681"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2682"></a>
<a name="numpy.i-2683"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2684"></a>
<a name="numpy.i-2685"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2686"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2687"></a>%#else
<a name="numpy.i-2688"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2689"></a>%#endif
<a name="numpy.i-2690"></a>
<a name="numpy.i-2691"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2692"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2693"></a>%#else
<a name="numpy.i-2694"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2695"></a>%#endif
<a name="numpy.i-2696"></a>
<a name="numpy.i-2697"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2698"></a>}
<a name="numpy.i-2699"></a>
<a name="numpy.i-2700"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3,
<a name="numpy.i-2701"></a>                      DATA_TYPE** ARGOUTVIEWM_FARRAY3)
<a name="numpy.i-2702"></a> */
<a name="numpy.i-2703"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2704"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DATA_TYPE** ARGOUTVIEWM_FARRAY3)
<a name="numpy.i-2705"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DATA_TYPE* data_temp = NULL    )
<a name="numpy.i-2706"></a>{
<a name="numpy.i-2707"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2708"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2709"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2710"></a>  $4 = &amp;data_temp;
<a name="numpy.i-2711"></a>}
<a name="numpy.i-2712"></a>%typemap(argout,
<a name="numpy.i-2713"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2714"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DATA_TYPE** ARGOUTVIEWM_FARRAY3)
<a name="numpy.i-2715"></a>{
<a name="numpy.i-2716"></a>  npy_intp dims[3] = { *$1, *$2, *$3 };
<a name="numpy.i-2717"></a>  PyObject* obj = PyArray_SimpleNewFromData(3, dims, DATA_TYPECODE, (void*)(*$4));
<a name="numpy.i-2718"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2719"></a>
<a name="numpy.i-2720"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2721"></a>
<a name="numpy.i-2722"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2723"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2724"></a>%#else
<a name="numpy.i-2725"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2726"></a>%#endif
<a name="numpy.i-2727"></a>
<a name="numpy.i-2728"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2729"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2730"></a>%#else
<a name="numpy.i-2731"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2732"></a>%#endif
<a name="numpy.i-2733"></a>
<a name="numpy.i-2734"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2735"></a>}
<a name="numpy.i-2736"></a>
<a name="numpy.i-2737"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2738"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2739"></a> */
<a name="numpy.i-2740"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2741"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2742"></a>  (DATA_TYPE* data_temp = NULL   , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2743"></a>{
<a name="numpy.i-2744"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2745"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2746"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2747"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2748"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2749"></a>}
<a name="numpy.i-2750"></a>%typemap(argout,
<a name="numpy.i-2751"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2752"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2753"></a>{
<a name="numpy.i-2754"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2755"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2756"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2757"></a>
<a name="numpy.i-2758"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2759"></a>
<a name="numpy.i-2760"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2761"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2762"></a>%#else
<a name="numpy.i-2763"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2764"></a>%#endif
<a name="numpy.i-2765"></a>
<a name="numpy.i-2766"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2767"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2768"></a>%#else
<a name="numpy.i-2769"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2770"></a>%#endif
<a name="numpy.i-2771"></a>
<a name="numpy.i-2772"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2773"></a>}
<a name="numpy.i-2774"></a>
<a name="numpy.i-2775"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-2776"></a>                      DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2777"></a> */
<a name="numpy.i-2778"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2779"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2780"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL   )
<a name="numpy.i-2781"></a>{
<a name="numpy.i-2782"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2783"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2784"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2785"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-2786"></a>  $5 = &amp;data_temp;
<a name="numpy.i-2787"></a>}
<a name="numpy.i-2788"></a>%typemap(argout,
<a name="numpy.i-2789"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2790"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2791"></a>{
<a name="numpy.i-2792"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-2793"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-2794"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2795"></a>
<a name="numpy.i-2796"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2797"></a>
<a name="numpy.i-2798"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2799"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2800"></a>%#else
<a name="numpy.i-2801"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2802"></a>%#endif
<a name="numpy.i-2803"></a>
<a name="numpy.i-2804"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2805"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2806"></a>%#else
<a name="numpy.i-2807"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2808"></a>%#endif
<a name="numpy.i-2809"></a>
<a name="numpy.i-2810"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2811"></a>}
<a name="numpy.i-2812"></a>
<a name="numpy.i-2813"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2814"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2815"></a> */
<a name="numpy.i-2816"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2817"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2818"></a>  (DATA_TYPE* data_temp = NULL    , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2819"></a>{
<a name="numpy.i-2820"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2821"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2822"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2823"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2824"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2825"></a>}
<a name="numpy.i-2826"></a>%typemap(argout,
<a name="numpy.i-2827"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2828"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3)
<a name="numpy.i-2829"></a>{
<a name="numpy.i-2830"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2831"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2832"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2833"></a>
<a name="numpy.i-2834"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2835"></a>
<a name="numpy.i-2836"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2837"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2838"></a>%#else
<a name="numpy.i-2839"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2840"></a>%#endif
<a name="numpy.i-2841"></a>
<a name="numpy.i-2842"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2843"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2844"></a>%#else
<a name="numpy.i-2845"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2846"></a>%#endif
<a name="numpy.i-2847"></a>
<a name="numpy.i-2848"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2849"></a>}
<a name="numpy.i-2850"></a>
<a name="numpy.i-2851"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-2852"></a>                      DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-2853"></a> */
<a name="numpy.i-2854"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2855"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-2856"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL    )
<a name="numpy.i-2857"></a>{
<a name="numpy.i-2858"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2859"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2860"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2861"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-2862"></a>  $5 = &amp;data_temp;
<a name="numpy.i-2863"></a>}
<a name="numpy.i-2864"></a>%typemap(argout,
<a name="numpy.i-2865"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2866"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-2867"></a>{
<a name="numpy.i-2868"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-2869"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-2870"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2871"></a>
<a name="numpy.i-2872"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2873"></a>
<a name="numpy.i-2874"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2875"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2876"></a>%#else
<a name="numpy.i-2877"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2878"></a>%#endif
<a name="numpy.i-2879"></a>
<a name="numpy.i-2880"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2881"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2882"></a>%#else
<a name="numpy.i-2883"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2884"></a>%#endif
<a name="numpy.i-2885"></a>
<a name="numpy.i-2886"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2887"></a>}
<a name="numpy.i-2888"></a>
<a name="numpy.i-2889"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2890"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2891"></a> */
<a name="numpy.i-2892"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2893"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2894"></a>  (DATA_TYPE* data_temp = NULL   , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2895"></a>{
<a name="numpy.i-2896"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2897"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2898"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2899"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2900"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2901"></a>}
<a name="numpy.i-2902"></a>%typemap(argout,
<a name="numpy.i-2903"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2904"></a>  (DATA_TYPE** ARGOUTVIEWM_ARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2905"></a>{
<a name="numpy.i-2906"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2907"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2908"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2909"></a>
<a name="numpy.i-2910"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2911"></a>
<a name="numpy.i-2912"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2913"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2914"></a>%#else
<a name="numpy.i-2915"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2916"></a>%#endif
<a name="numpy.i-2917"></a>
<a name="numpy.i-2918"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2919"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2920"></a>%#else
<a name="numpy.i-2921"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2922"></a>%#endif
<a name="numpy.i-2923"></a>
<a name="numpy.i-2924"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2925"></a>}
<a name="numpy.i-2926"></a>
<a name="numpy.i-2927"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-2928"></a>                      DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2929"></a> */
<a name="numpy.i-2930"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2931"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2932"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL   )
<a name="numpy.i-2933"></a>{
<a name="numpy.i-2934"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-2935"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-2936"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-2937"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-2938"></a>  $5 = &amp;data_temp;
<a name="numpy.i-2939"></a>}
<a name="numpy.i-2940"></a>%typemap(argout,
<a name="numpy.i-2941"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Utilities")
<a name="numpy.i-2942"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_ARRAY4)
<a name="numpy.i-2943"></a>{
<a name="numpy.i-2944"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-2945"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-2946"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2947"></a>
<a name="numpy.i-2948"></a>  if (!array) SWIG_fail;
<a name="numpy.i-2949"></a>
<a name="numpy.i-2950"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2951"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2952"></a>%#else
<a name="numpy.i-2953"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2954"></a>%#endif
<a name="numpy.i-2955"></a>
<a name="numpy.i-2956"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2957"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2958"></a>%#else
<a name="numpy.i-2959"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2960"></a>%#endif
<a name="numpy.i-2961"></a>
<a name="numpy.i-2962"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-2963"></a>}
<a name="numpy.i-2964"></a>
<a name="numpy.i-2965"></a>/* Typemap suite for (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2,
<a name="numpy.i-2966"></a>                      DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2967"></a> */
<a name="numpy.i-2968"></a>%typemap(in,numinputs=0)
<a name="numpy.i-2969"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    )
<a name="numpy.i-2970"></a>  (DATA_TYPE* data_temp = NULL    , DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp)
<a name="numpy.i-2971"></a>{
<a name="numpy.i-2972"></a>  $1 = &amp;data_temp;
<a name="numpy.i-2973"></a>  $2 = &amp;dim1_temp;
<a name="numpy.i-2974"></a>  $3 = &amp;dim2_temp;
<a name="numpy.i-2975"></a>  $4 = &amp;dim3_temp;
<a name="numpy.i-2976"></a>  $5 = &amp;dim4_temp;
<a name="numpy.i-2977"></a>}
<a name="numpy.i-2978"></a>%typemap(argout,
<a name="numpy.i-2979"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-2980"></a>  (DATA_TYPE** ARGOUTVIEWM_FARRAY4, DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4)
<a name="numpy.i-2981"></a>{
<a name="numpy.i-2982"></a>  npy_intp dims[4] = { *$2, *$3, *$4 , *$5 };
<a name="numpy.i-2983"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$1));
<a name="numpy.i-2984"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-2985"></a>
<a name="numpy.i-2986"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-2987"></a>
<a name="numpy.i-2988"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-2989"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-2990"></a>%#else
<a name="numpy.i-2991"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-2992"></a>%#endif
<a name="numpy.i-2993"></a>
<a name="numpy.i-2994"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-2995"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-2996"></a>%#else
<a name="numpy.i-2997"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-2998"></a>%#endif
<a name="numpy.i-2999"></a>
<a name="numpy.i-3000"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-3001"></a>}
<a name="numpy.i-3002"></a>
<a name="numpy.i-3003"></a>/* Typemap suite for (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4,
<a name="numpy.i-3004"></a>                      DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-3005"></a> */
<a name="numpy.i-3006"></a>%typemap(in,numinputs=0)
<a name="numpy.i-3007"></a>  (DIM_TYPE* DIM1    , DIM_TYPE* DIM2    , DIM_TYPE* DIM3    , DIM_TYPE* DIM4    , DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-3008"></a>  (DIM_TYPE dim1_temp, DIM_TYPE dim2_temp, DIM_TYPE dim3_temp, DIM_TYPE dim4_temp, DATA_TYPE* data_temp = NULL    )
<a name="numpy.i-3009"></a>{
<a name="numpy.i-3010"></a>  $1 = &amp;dim1_temp;
<a name="numpy.i-3011"></a>  $2 = &amp;dim2_temp;
<a name="numpy.i-3012"></a>  $3 = &amp;dim3_temp;
<a name="numpy.i-3013"></a>  $4 = &amp;dim4_temp;
<a name="numpy.i-3014"></a>  $5 = &amp;data_temp;
<a name="numpy.i-3015"></a>}
<a name="numpy.i-3016"></a>%typemap(argout,
<a name="numpy.i-3017"></a>         fragment="NumPy_Backward_Compatibility,NumPy_Array_Requirements,NumPy_Utilities")
<a name="numpy.i-3018"></a>  (DIM_TYPE* DIM1, DIM_TYPE* DIM2, DIM_TYPE* DIM3, DIM_TYPE* DIM4, DATA_TYPE** ARGOUTVIEWM_FARRAY4)
<a name="numpy.i-3019"></a>{
<a name="numpy.i-3020"></a>  npy_intp dims[4] = { *$1, *$2, *$3 , *$4 };
<a name="numpy.i-3021"></a>  PyObject* obj = PyArray_SimpleNewFromData(4, dims, DATA_TYPECODE, (void*)(*$5));
<a name="numpy.i-3022"></a>  PyArrayObject* array = (PyArrayObject*) obj;
<a name="numpy.i-3023"></a>
<a name="numpy.i-3024"></a>  if (!array || !require_fortran(array)) SWIG_fail;
<a name="numpy.i-3025"></a>
<a name="numpy.i-3026"></a>%#ifdef SWIGPY_USE_CAPSULE
<a name="numpy.i-3027"></a>    PyObject* cap = PyCapsule_New((void*)(*$1), SWIGPY_CAPSULE_NAME, free_cap);
<a name="numpy.i-3028"></a>%#else
<a name="numpy.i-3029"></a>    PyObject* cap = PyCObject_FromVoidPtr((void*)(*$1), free);
<a name="numpy.i-3030"></a>%#endif
<a name="numpy.i-3031"></a>
<a name="numpy.i-3032"></a>%#if NPY_API_VERSION &lt; 0x00000007
<a name="numpy.i-3033"></a>  PyArray_BASE(array) = cap;
<a name="numpy.i-3034"></a>%#else
<a name="numpy.i-3035"></a>  PyArray_SetBaseObject(array,cap);
<a name="numpy.i-3036"></a>%#endif
<a name="numpy.i-3037"></a>
<a name="numpy.i-3038"></a>  $result = SWIG_Python_AppendOutput($result,obj);
<a name="numpy.i-3039"></a>}
<a name="numpy.i-3040"></a>
<a name="numpy.i-3041"></a>%enddef    /* %numpy_typemaps() macro */
<a name="numpy.i-3042"></a>/* *************************************************************** */
<a name="numpy.i-3043"></a>
<a name="numpy.i-3044"></a>/* Concrete instances of the %numpy_typemaps() macro: Each invocation
<a name="numpy.i-3045"></a> * below applies all of the typemaps above to the specified data type.
<a name="numpy.i-3046"></a> */
<a name="numpy.i-3047"></a>%numpy_typemaps(signed char       , NPY_BYTE     , int)
<a name="numpy.i-3048"></a>%numpy_typemaps(unsigned char     , NPY_UBYTE    , int)
<a name="numpy.i-3049"></a>%numpy_typemaps(short             , NPY_SHORT    , int)
<a name="numpy.i-3050"></a>%numpy_typemaps(unsigned short    , NPY_USHORT   , int)
<a name="numpy.i-3051"></a>%numpy_typemaps(int               , NPY_INT      , int)
<a name="numpy.i-3052"></a>%numpy_typemaps(unsigned int      , NPY_UINT     , int)
<a name="numpy.i-3053"></a>%numpy_typemaps(long              , NPY_LONG     , int)
<a name="numpy.i-3054"></a>%numpy_typemaps(unsigned long     , NPY_ULONG    , int)
<a name="numpy.i-3055"></a>%numpy_typemaps(long long         , NPY_LONGLONG , int)
<a name="numpy.i-3056"></a>%numpy_typemaps(unsigned long long, NPY_ULONGLONG, int)
<a name="numpy.i-3057"></a>%numpy_typemaps(float             , NPY_FLOAT    , int)
<a name="numpy.i-3058"></a>%numpy_typemaps(double            , NPY_DOUBLE   , int)
<a name="numpy.i-3059"></a>
<a name="numpy.i-3060"></a>/* ***************************************************************
<a name="numpy.i-3061"></a> * The follow macro expansion does not work, because C++ bool is 4
<a name="numpy.i-3062"></a> * bytes and NPY_BOOL is 1 byte
<a name="numpy.i-3063"></a> *
<a name="numpy.i-3064"></a> *    %numpy_typemaps(bool, NPY_BOOL, int)
<a name="numpy.i-3065"></a> */
<a name="numpy.i-3066"></a>
<a name="numpy.i-3067"></a>/* ***************************************************************
<a name="numpy.i-3068"></a> * On my Mac, I get the following warning for this macro expansion:
<a name="numpy.i-3069"></a> * 'swig/python detected a memory leak of type 'long double *', no destructor found.'
<a name="numpy.i-3070"></a> *
<a name="numpy.i-3071"></a> *    %numpy_typemaps(long double, NPY_LONGDOUBLE, int)
<a name="numpy.i-3072"></a> */
<a name="numpy.i-3073"></a>
<a name="numpy.i-3074"></a>/* ***************************************************************
<a name="numpy.i-3075"></a> * Swig complains about a syntax error for the following macro
<a name="numpy.i-3076"></a> * expansions:
<a name="numpy.i-3077"></a> *
<a name="numpy.i-3078"></a> *    %numpy_typemaps(complex float,  NPY_CFLOAT , int)
<a name="numpy.i-3079"></a> *
<a name="numpy.i-3080"></a> *    %numpy_typemaps(complex double, NPY_CDOUBLE, int)
<a name="numpy.i-3081"></a> *
<a name="numpy.i-3082"></a> *    %numpy_typemaps(complex long double, NPY_CLONGDOUBLE, int)
<a name="numpy.i-3083"></a> */
<a name="numpy.i-3084"></a>
<a name="numpy.i-3085"></a>#endif /* SWIGPYTHON */
</pre></div></td></tr></table>

    </div>
  


        </div>
        
      </div>
    </div>
  </div>
  
  <div data-module="source/set-changeset" data-hash="a6eab5db0d6764b6de7a9f2069e4474a3c404761"></div>



  
    
    
    
  
  

  </div>

        
        
        
          
    
    
  
        
      </div>
    </div>
    <div id="code-search-cta"></div>
  </div>

      </div>
    </div>
  

  
</div>

  <div id="adg3-dialog"></div>



  

<div data-module="components/mentions/index">
  
    
    
  
  
    
    
  
  
    
    
  
</div>
<div data-module="components/typeahead/emoji/index">
  
    
    
  
</div>

<div data-module="components/repo-typeahead/index">
  
    
    
  
</div>

    
    
  

    
    
  

    
    
  

    
    
  


  


    
    
  

    
    
  


  
    
    
  
  
    
    
  
  
    
    
  
  
    
    
  
  
    
    
  
  
    
    
  
  
    
    
  


  
  
  <aui-inline-dialog
    id="help-menu-dialog"
    data-aui-alignment="bottom right"

    
    data-aui-alignment-static="true"
    data-module="header/help-menu"
    responds-to="toggle"
    aria-hidden="true">

  <div id="help-menu-section">
    <h1 class="help-menu-heading">Help</h1>

    <form id="help-menu-search-form" class="aui" target="_blank" method="get"
        action="https://support.atlassian.com/customer/search">
      <span id="help-menu-search-icon" class="aui-icon aui-icon-large aui-iconfont-search"></span>
      <input id="help-menu-search-form-input" name="q" class="text" type="text" placeholder="Ask a question">
    </form>

    <ul id="help-menu-links">
      <li>
        <a class="support-ga" data-support-gaq-page="DocumentationHome"
            href="https://confluence.atlassian.com/x/bgozDQ" target="_blank">
          Online help
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="GitTutorials"
            href="https://www.atlassian.com/git?utm_source=bitbucket&amp;utm_medium=link&amp;utm_campaign=help_dropdown&amp;utm_content=learn_git"
            target="_blank">
          Learn Git
        </a>
      </li>
      <li>
        <a id="keyboard-shortcuts-link"
           href="#">Keyboard shortcuts</a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="DocumentationTutorials"
            href="https://confluence.atlassian.com/x/Q4sFLQ" target="_blank">
          Bitbucket tutorials
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="SiteStatus"
            href="https://status.bitbucket.org/" target="_blank">
          Site status
        </a>
      </li>
      <li>
        <a class="support-ga" data-support-gaq-page="Home"
            href="https://support.atlassian.com/bitbucket/" target="_blank">
          Support
        </a>
      </li>
    </ul>
  </div>
</aui-inline-dialog>
  


  <div class="omnibar" data-module="components/omnibar/index">
    <form class="omnibar-form aui"></form>
  </div>
  
    
    
  
  
    
    
  
  
    
    
  
  
    
    
  





  

  <div class="_mustache-templates">
    
      <script id="branch-checkout-template" type="text/html">
        

<div id="checkout-branch-contents">
  <div class="command-line">
    <p>
      Check out this branch on your local machine to begin working on it.
    </p>
    <input type="text" class="checkout-command" readonly="readonly"
        
           value="git fetch && git checkout [[branchName]]"
        
        >
  </div>
  
    <div class="sourcetree-callout clone-in-sourcetree"
  data-module="components/clone/clone-in-sourcetree"
  data-https-url="https://vchaplin@bitbucket.org/vchaplin/hifu.git"
  data-ssh-url="ssh://git@bitbucket.org/vchaplin/hifu.git">

  <div>
    <button class="aui-button aui-button-primary">
      
        Check out in SourceTree
      
    </button>
  </div>

  <p class="windows-text">
    
      <a href="http://www.sourcetreeapp.com/?utm_source=internal&amp;utm_medium=link&amp;utm_campaign=clone_repo_win" target="_blank">Atlassian SourceTree</a>
      is a free Git and Mercurial client for Windows.
    
  </p>
  <p class="mac-text">
    
      <a href="http://www.sourcetreeapp.com/?utm_source=internal&amp;utm_medium=link&amp;utm_campaign=clone_repo_mac" target="_blank">Atlassian SourceTree</a>
      is a free Git and Mercurial client for Mac.
    
  </p>
</div>
  
</div>

      </script>
    
      <script id="branch-dialog-template" type="text/html">
        

<div class="tabbed-filter-widget branch-dialog">
  <div class="tabbed-filter">
    <input placeholder="Filter branches" class="filter-box" autosave="branch-dropdown-8608639" type="text">
    [[^ignoreTags]]
      <div class="aui-tabs horizontal-tabs aui-tabs-disabled filter-tabs">
        <ul class="tabs-menu">
          <li class="menu-item active-tab"><a href="#branches">Branches</a></li>
          <li class="menu-item"><a href="#tags">Tags</a></li>
        </ul>
      </div>
    [[/ignoreTags]]
  </div>
  
    <div class="tab-pane active-pane" id="branches" data-filter-placeholder="Filter branches">
      <ol class="filter-list">
        <li class="empty-msg">No matching branches</li>
        [[#branches]]
          
            [[#hasMultipleHeads]]
              [[#heads]]
                <li class="comprev filter-item">
                  <a class="pjax-trigger filter-item-link" href="/vchaplin/hifu/src/[[changeset]]/code/myPy/numpy.i?at=[[safeName]]"
                     title="[[name]]">
                    [[name]] ([[shortChangeset]])
                  </a>
                </li>
              [[/heads]]
            [[/hasMultipleHeads]]
            [[^hasMultipleHeads]]
              <li class="comprev filter-item">
                <a class="pjax-trigger filter-item-link" href="/vchaplin/hifu/src/[[changeset]]/code/myPy/numpy.i?at=[[safeName]]" title="[[name]]">
                  [[name]]
                </a>
              </li>
            [[/hasMultipleHeads]]
          
        [[/branches]]
      </ol>
    </div>
    <div class="tab-pane" id="tags" data-filter-placeholder="Filter tags">
      <ol class="filter-list">
        <li class="empty-msg">No matching tags</li>
        [[#tags]]
          <li class="comprev filter-item">
            <a class="pjax-trigger filter-item-link" href="/vchaplin/hifu/src/[[changeset]]/code/myPy/numpy.i?at=[[safeName]]" title="[[name]]">
              [[name]]
            </a>
          </li>
        [[/tags]]
      </ol>
    </div>
  
</div>

      </script>
    
      <script id="image-upload-template" type="text/html">
        

<form id="upload-image" method="POST"
    
      action="/xhr/vchaplin/hifu/image-upload/"
    >
  <input type='hidden' name='csrfmiddlewaretoken' value='vIivVg8MAvYqPDJLbQV92KXJulH9wEnT' />

  <div class="drop-target">
    <p class="centered">Drag image here</p>
  </div>

  
  <div>
    <button class="aui-button click-target">Select an image</button>
    <input name="file" type="file" class="hidden file-target"
           accept="image/jpeg, image/gif, image/png" />
    <input type="submit" class="hidden">
  </div>
</form>


      </script>
    
      <script id="mention-result" type="text/html">
        
<span class="mention-result">
  <span class="aui-avatar aui-avatar-small mention-result--avatar">
    <span class="aui-avatar-inner">
      <img src="[[avatar_url]]">
    </span>
  </span>
  [[#display_name]]
    <span class="display-name mention-result--display-name">[[&display_name]]</span> <small class="username mention-result--username">[[&username]]</small>
  [[/display_name]]
  [[^display_name]]
    <span class="username mention-result--username">[[&username]]</span>
  [[/display_name]]
  [[#is_teammate]][[^is_team]]
    <span class="aui-lozenge aui-lozenge-complete aui-lozenge-subtle mention-result--lozenge">teammate</span>
  [[/is_team]][[/is_teammate]]
</span>
      </script>
    
      <script id="mention-call-to-action" type="text/html">
        
[[^query]]
<li class="bb-typeahead-item">Begin typing to search for a user</li>
[[/query]]
[[#query]]
<li class="bb-typeahead-item">Continue typing to search for a user</li>
[[/query]]

      </script>
    
      <script id="mention-no-results" type="text/html">
        
[[^searching]]
<li class="bb-typeahead-item">Found no matching users for <em>[[query]]</em>.</li>
[[/searching]]
[[#searching]]
<li class="bb-typeahead-item bb-typeahead-searching">Searching for <em>[[query]]</em>.</li>
[[/searching]]

      </script>
    
      <script id="emoji-result" type="text/html">
        
<span class="emoji-result">
  <span class="emoji-result--avatar">
    <img class="emoji" src="[[src]]">
  </span>
  <span class="name emoji-result--name">[[&name]]</span>
</span>

      </script>
    
      <script id="repo-typeahead-result" type="text/html">
        <span class="aui-avatar aui-avatar-project aui-avatar-xsmall">
  <span class="aui-avatar-inner">
    <img src="[[avatar]]">
  </span>
</span>
<span class="owner">[[&owner]]</span>/<span class="slug">[[&slug]]</span>

      </script>
    
      <script id="share-form-template" type="text/html">
        

<div class="error aui-message hidden">
  <span class="aui-icon icon-error"></span>
  <div class="message"></div>
</div>
<form class="aui">
  <table class="widget bb-list aui">
    <thead>
    <tr class="assistive">
      <th class="user">User</th>
      <th class="role">Role</th>
      <th class="actions">Actions</th>
    </tr>
    </thead>
    <tbody>
      <tr class="form">
        <td colspan="2">
          <input type="text" class="text bb-user-typeahead user-or-email"
                 placeholder="Username or email address"
                 autocomplete="off"
                 data-bb-typeahead-focus="false"
                 [[#disabled]]disabled[[/disabled]]>
        </td>
        <td class="actions">
          <button type="submit" class="aui-button aui-button-light" disabled>Add</button>
        </td>
      </tr>
    </tbody>
  </table>
</form>

      </script>
    
      <script id="share-detail-template" type="text/html">
        

[[#username]]
<td class="user
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]"
    [[#error]]data-error="[[error]]"[[/error]]>
  <div title="[[displayName]]">
    <a href="/[[username]]/" class="user">
      <span class="aui-avatar aui-avatar-xsmall">
        <span class="aui-avatar-inner">
          <img src="[[avatar]]">
        </span>
      </span>
      <span>[[displayName]]</span>
    </a>
  </div>
</td>
[[/username]]
[[^username]]
<td class="email
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]"
    [[#error]]data-error="[[error]]"[[/error]]>
  <div title="[[email]]">
    <span class="aui-icon aui-icon-small aui-iconfont-email"></span>
    [[email]]
  </div>
</td>
[[/username]]
<td class="role
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]">
  <div>
    [[#group]]
      [[#hasCustomGroups]]
        <select class="group [[#noGroupChoices]]hidden[[/noGroupChoices]]">
          [[#groups]]
            <option value="[[slug]]"
                [[#isSelected]]selected[[/isSelected]]>
              [[name]]
            </option>
          [[/groups]]
        </select>
      [[/hasCustomGroups]]
      [[^hasCustomGroups]]
      <label>
        <input type="checkbox" class="admin"
            [[#isAdmin]]checked[[/isAdmin]]>
        Administrator
      </label>
      [[/hasCustomGroups]]
    [[/group]]
    [[^group]]
      <ul>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^read]]aui-lozenge-subtle[[/read]]"
            data-permission="read">
          read
        </li>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^write]]aui-lozenge-subtle[[/write]]"
            data-permission="write">
          write
        </li>
        <li class="permission aui-lozenge aui-lozenge-complete
            [[^admin]]aui-lozenge-subtle[[/admin]]"
            data-permission="admin">
          admin
        </li>
      </ul>
    [[/group]]
  </div>
</td>
<td class="actions
    [[#hasCustomGroups]]custom-groups[[/hasCustomGroups]]">
  <div>
    <a href="#" class="delete">
      <span class="aui-icon aui-icon-small aui-iconfont-remove">Delete</span>
    </a>
  </div>
</td>

      </script>
    
      <script id="share-team-template" type="text/html">
        

<div class="clearfix">
  <span class="team-avatar-container">
    <span class="aui-avatar aui-avatar-medium">
      <span class="aui-avatar-inner">
        <img src="[[avatar]]">
      </span>
    </span>
  </span>
  <span class="team-name-container">
    [[display_name]]
  </span>
</div>
<p class="helptext">
  
    Existing users are granted access to this team immediately.
    New users will be sent an invitation.
  
</p>
<div class="share-form"></div>

      </script>
    
      <script id="scope-list-template" type="text/html">
        <ul class="scope-list">
  [[#scopes]]
    <li class="scope-list--item">
      <span class="scope-list--icon aui-icon aui-icon-small [[icon]]"></span>
      <span class="scope-list--description">[[description]]</span>
    </li>
  [[/scopes]]
</ul>

      </script>
    
      <script id="source-changeset" type="text/html">
        

<a href="/vchaplin/hifu/src/[[raw_node]]/[[path]]?at=master"
    class="[[#selected]]highlight[[/selected]]"
    data-hash="[[node]]">
  [[#author.username]]
    <span class="aui-avatar aui-avatar-xsmall">
      <span class="aui-avatar-inner">
        <img src="[[author.avatar]]">
      </span>
    </span>
    <span class="author" title="[[raw_author]]">[[author.display_name]]</span>
  [[/author.username]]
  [[^author.username]]
    <span class="aui-avatar aui-avatar-xsmall">
      <span class="aui-avatar-inner">
        <img src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/img/default_avatar/user_blue.svg">
      </span>
    </span>
    <span class="author unmapped" title="[[raw_author]]">[[author]]</span>
  [[/author.username]]
  <time datetime="[[utctimestamp]]" data-title="true">[[utctimestamp]]</time>
  <span class="message">[[message]]</span>
</a>

      </script>
    
      <script id="embed-template" type="text/html">
        

<form class="aui inline-dialog-embed-dialog">
  <label for="embed-code-[[dialogId]]">Embed this source in another page:</label>
  <input type="text" readonly="true" value="&lt;script src=&quot;[[url]]&quot;&gt;&lt;/script&gt;" id="embed-code-[[dialogId]]" class="embed-code">
</form>

      </script>
    
      <script id="edit-form-template" type="text/html">
        


<form class="bb-content-container online-edit-form aui"
      data-repository="[[owner]]/[[slug]]"
      data-destination-repository="[[destinationOwner]]/[[destinationSlug]]"
      data-local-id="[[localID]]"
      [[#isWriter]]data-is-writer="true"[[/isWriter]]
      [[#hasPushAccess]]data-has-push-access="true"[[/hasPushAccess]]
      [[#isPullRequest]]data-is-pull-request="true"[[/isPullRequest]]
      [[#hideCreatePullRequest]]data-hide-create-pull-request="true"[[/hideCreatePullRequest]]
      data-hash="[[hash]]"
      data-branch="[[branch]]"
      data-path="[[path]]"
      data-is-create="[[isCreate]]"
      data-preview-url="/xhr/[[owner]]/[[slug]]/preview/[[hash]]/[[encodedPath]]"
      data-preview-error="We had trouble generating your preview."
      data-unsaved-changes-error="Your changes will be lost. Are you sure you want to leave?">
  <div class="bb-content-container-header">
    <div class="bb-content-container-header-primary">
      <h2 class="bb-content-container-heading">
        [[#isCreate]]
          [[#branch]]
            
              Creating <span class="edit-path">[[path]]</span> on branch: <strong>[[branch]]</strong>
            
          [[/branch]]
          [[^branch]]
            [[#path]]
              
                Creating <span class="edit-path">[[path]]</span>
              
            [[/path]]
            [[^path]]
              
                Creating <span class="edit-path">unnamed file</span>
              
            [[/path]]
          [[/branch]]
        [[/isCreate]]
        [[^isCreate]]
          
            Editing <span class="edit-path">[[path]]</span> on branch: <strong>[[branch]]</strong>
          
        [[/isCreate]]
      </h2>
    </div>
    <div class="bb-content-container-header-secondary">
      <div class="hunk-nav aui-buttons">
        <button class="prev-hunk-button aui-button aui-button-light"
            disabled="disabled" aria-disabled="true"
            title="Previous change">
          <span class="aui-icon aui-icon-small aui-iconfont-up">Previous change</span>
        </button>
        <button class="next-hunk-button aui-button aui-button-light"
            disabled="disabled" aria-disabled="true"
            title="Next change">
          <span class="aui-icon aui-icon-small aui-iconfont-down">Next change</span>
        </button>
      </div>
    </div>
  </div>
  <div class="bb-content-container-body has-header has-footer file-editor">
    <textarea id="id_source"></textarea>
  </div>
  <div class="preview-pane"></div>
  <div class="bb-content-container-footer">
    <div class="bb-content-container-footer-primary">
      <div id="syntax-mode" class="bb-content-container-item field">
        <label for="id_syntax-mode" class="online-edit-form--label">Syntax mode:</label>
        <select id="id_syntax-mode">
          [[#syntaxes]]
            <option value="[[#mime]][[mime]][[/mime]][[^mime]][[mode]][[/mime]]">[[name]]</option>
          [[/syntaxes]]
        </select>
      </div>
      <div id="indent-mode" class="bb-content-container-item field">
        <label for="id_indent-mode" class="online-edit-form--label">Indent mode:</label>
        <select id="id_indent-mode">
          <option value="tabs">Tabs</option>
          <option value="spaces">Spaces</option>
        </select>
      </div>
      <div id="indent-size" class="bb-content-container-item field">
        <label for="id_indent-size" class="online-edit-form--label">Indent size:</label>
        <select id="id_indent-size">
          <option value="2">2</option>
          <option value="4">4</option>
          <option value="8">8</option>
        </select>
      </div>
      <div id="wrap-mode" class="bb-content-container-item field">
        <label for="id_wrap-mode" class="online-edit-form--label">Line wrap:</label>
        <select id="id_wrap-mode">
          <option value="">Off</option>
          <option value="soft">On</option>
        </select>
      </div>
    </div>
    <div class="bb-content-container-footer-secondary">
      [[^isCreate]]
        <button class="preview-button aui-button aui-button-light"
                disabled="disabled" aria-disabled="true"
                data-preview-label="View diff"
                data-edit-label="Edit file">View diff</button>
      [[/isCreate]]
      <button class="save-button aui-button aui-button-primary"
              disabled="disabled" aria-disabled="true">Commit</button>
      [[^isCreate]]
        <a class="aui-button aui-button-link cancel-link" href="#">Cancel</a>
      [[/isCreate]]
    </div>
  </div>
</form>

      </script>
    
      <script id="commit-form-template" type="text/html">
        

<form class="aui commit-form"
      data-title="Commit changes"
      [[#isDelete]]
        data-default-message="[[filename]] deleted online with Bitbucket"
      [[/isDelete]]
      [[#isCreate]]
        data-default-message="[[filename]] created online with Bitbucket"
      [[/isCreate]]
      [[^isDelete]]
        [[^isCreate]]
          data-default-message="[[filename]] edited online with Bitbucket"
        [[/isCreate]]
      [[/isDelete]]
      data-fork-error="We had trouble creating your fork."
      data-commit-error="We had trouble committing your changes."
      data-pull-request-error="We had trouble creating your pull request."
      data-update-error="We had trouble updating your pull request."
      data-branch-conflict-error="A branch with that name already exists."
      data-forking-message="Forking repository"
      data-committing-message="Committing changes"
      data-merging-message="Branching and merging changes"
      data-creating-pr-message="Creating pull request"
      data-updating-pr-message="Updating pull request"
      data-cta-label="Commit"
      data-cancel-label="Cancel">
  [[#isDelete]]
    <div class="aui-message info">
      <span class="aui-icon icon-info"></span>
      <span class="message">
        
          Committing this change will delete [[filename]] from your repository.
        
      </span>
    </div>
  [[/isDelete]]
  <div class="aui-message error hidden">
    <span class="aui-icon icon-error"></span>
    <span class="message"></span>
  </div>
  [[^isWriter]]
    <div class="aui-message info">
      <span class="aui-icon icon-info"></span>
      <p class="title">
        
          You don't have write access to this repository.
        
      </p>
      <span class="message">
        
          We'll create a fork for your changes and submit a
          pull request back to this repository.
        
      </span>
    </div>
  [[/isWriter]]
  [[#isRename]]
    <div class="field-group">
      <label for="id_path">New path</label>
      <input type="text" id="id_path" class="text" value="[[path]]"/>
    </div>
  [[/isRename]]
  <div class="field-group">
    <label for="id_message">Commit message</label>
    <textarea id="id_message" class="long-field textarea"></textarea>
  </div>
  [[^isPullRequest]]
    [[#isWriter]]
      <fieldset class="group">
        <div class="checkbox">
          [[#hasPushAccess]]
            [[^hideCreatePullRequest]]
              <input id="id_create-pullrequest" class="checkbox" type="checkbox">
              <label for="id_create-pullrequest">Create a pull request for this change</label>
            [[/hideCreatePullRequest]]
          [[/hasPushAccess]]
          [[^hasPushAccess]]
            <input id="id_create-pullrequest" class="checkbox" type="checkbox" checked="checked" aria-disabled="true" disabled="true">
            <label for="id_create-pullrequest" title="Branch restrictions do not allow you to update this branch.">Create a pull request for this change</label>
          [[/hasPushAccess]]
        </div>
      </fieldset>
      <div id="pr-fields">
        <div id="branch-name-group" class="field-group">
          <label for="id_branch-name">Branch name</label>
          <input type="text" id="id_branch-name" class="text long-field">
        </div>
        

<div class="field-group" id="id_reviewers_group">
  <label for="reviewers">Reviewers</label>

  
  <input id="reviewers" name="reviewers" type="hidden"
          value=""
          data-mention-url="/xhr/mentions/repositories/:dest_username/:dest_slug"
          data-reviewers="[]"
          data-suggested="[]"
          data-locked="[]">

  <div class="error"></div>
  <div class="suggested-reviewers"></div>

</div>

      </div>
    [[/isWriter]]
  [[/isPullRequest]]
  <button type="submit" id="id_submit">Commit</button>
</form>

      </script>
    
      <script id="merge-message-template" type="text/html">
        Merged [[hash]] into [[branch]]

[[message]]

      </script>
    
      <script id="commit-merge-error-template" type="text/html">
        



  We had trouble merging your changes. We stored them on the <strong>[[branch]]</strong> branch, so feel free to
  <a href="/[[owner]]/[[slug]]/full-commit/[[hash]]/[[path]]?at=[[encodedBranch]]">view them</a> or
  <a href="#" class="create-pull-request-link">create a pull request</a>.


      </script>
    
      <script id="selected-reviewer-template" type="text/html">
        <div class="aui-avatar aui-avatar-xsmall">
  <div class="aui-avatar-inner">
    <img src="[[avatar_url]]">
  </div>
</div>
[[display_name]]

      </script>
    
      <script id="suggested-reviewer-template" type="text/html">
        <button class="aui-button aui-button-link" type="button" tabindex="-1">[[display_name]]</button>

      </script>
    
      <script id="suggested-reviewers-template" type="text/html">
        

<span class="suggested-reviewer-list-label">Recent:</span>
<ul class="suggested-reviewer-list unstyled-list"></ul>

      </script>
    
      <script id="omnibar-form-template" type="text/html">
        <div class="omnibar-input-container">
  <input class="omnibar-input" type="text" [[#placeholder]]placeholder="[[placeholder]]"[[/placeholder]]>
</div>
<ul class="omnibar-result-group-list"></ul>

      </script>
    
      <script id="omnibar-blank-slate-template" type="text/html">
        

<div class="omnibar-blank-slate">No results found</div>

      </script>
    
      <script id="omnibar-result-group-list-item-template" type="text/html">
        <div class="omnibar-result-group-header clearfix">
  <h2 class="omnibar-result-group-label" title="[[label]]">[[label]]</h2>
  <span class="omnibar-result-group-context" title="[[context]]">[[context]]</span>
</div>
<ul class="omnibar-result-list unstyled-list"></ul>

      </script>
    
      <script id="omnibar-result-list-item-template" type="text/html">
        [[#url]]
  <a href="[[&url]]" class="omnibar-result-label">[[&label]]</a>
[[/url]]
[[^url]]
  <span class="omnibar-result-label">[[&label]]</span>
[[/url]]
[[#context]]
  <span class="omnibar-result-context">[[context]]</span>
[[/context]]

      </script>
    
  </div>




  
  


<script nonce="CMqjSUUZf83A8MTx">
  window.__initial_state__ = {"global": {"features": {"pr-merge-sign-off": true, "comment-likes": true, "fast-pr-merges": true, "twofactor-u2f": true, "clone-mirrors": true, "repo-onboarding": true, "require-issue-key": true, "snippets": true, "adg3": true, "fabric-emoji": true, "revert-pull-request": true, "new-dashboard": true, "integrations-page": true, "online-ides": true, "new-signup-flow": true, "fe_word_diff": true, "clonebundles": true, "use-moneybucket": true, "pinned-issue-comments": true, "invitation-matching-email": true, "diff-renames-public": true, "app-passwords": true, "ignore-whitespace-button": true, "trello-boards": true, "atlassian-editor": false, "squash-merge": true, "pr-shared-component": true, "build-status": true, "projects": true, "evolution": false, "pr-checkout-command": true, "new-features-management": true, "repo-avatar-revival": true, "diff-renames-internal": true, "search-syntax-highlighting": true, "code-search-cta-launch": true, "new-features": true, "promote-bello": true, "search-results-adg3-page": true, "lfs_post_beta": true, "two-step": true, "bundle-splitting": true}, "locale": "en", "geoip_country": "US", "targetFeatures": {"pr-merge-sign-off": true, "comment-likes": true, "fast-pr-merges": true, "twofactor-u2f": true, "clone-mirrors": true, "repo-onboarding": true, "require-issue-key": true, "snippets": true, "adg3": true, "fabric-emoji": true, "revert-pull-request": true, "new-dashboard": true, "integrations-page": true, "online-ides": true, "new-signup-flow": true, "fe_word_diff": true, "clonebundles": true, "use-moneybucket": true, "pinned-issue-comments": true, "invitation-matching-email": true, "diff-renames-public": true, "app-passwords": true, "ignore-whitespace-button": true, "trello-boards": true, "atlassian-editor": false, "squash-merge": true, "pr-shared-component": true, "build-status": true, "projects": true, "evolution": false, "pr-checkout-command": true, "new-features-management": true, "repo-avatar-revival": true, "diff-renames-internal": true, "search-syntax-highlighting": true, "code-search-cta-launch": true, "new-features": true, "promote-bello": true, "search-results-adg3-page": true, "lfs_post_beta": true, "two-step": true, "bundle-splitting": true}, "isFocusedTask": false, "teams": [], "bitbucketActions": [{"analytics_label": null, "icon_class": "", "badge_label": null, "weight": 100, "url": "/repo/create?owner=vchaplin", "tab_name": null, "can_display": true, "label": "<strong>Repository<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repository-create-drawer-item", "icon": ""}, {"analytics_label": null, "icon_class": "", "badge_label": null, "weight": 110, "url": "/account/create-team/", "tab_name": null, "can_display": true, "label": "<strong>Team<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "team-create-drawer-item", "icon": ""}, {"analytics_label": null, "icon_class": "", "badge_label": null, "weight": 120, "url": "/account/projects/create?owner=vchaplin", "tab_name": null, "can_display": true, "label": "<strong>Project<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "project-create-drawer-item", "icon": ""}, {"analytics_label": null, "icon_class": "", "badge_label": null, "weight": 130, "url": "/snippets/new?owner=vchaplin", "tab_name": null, "can_display": true, "label": "<strong>Snippet<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "snippet-create-drawer-item", "icon": ""}], "targetUser": {"username": "vchaplin", "website": null, "display_name": "vchaplin", "account_id": "557058:8085dfdf-6e0a-446a-a63b-de16571b5502", "links": {"self": {"href": "https://bitbucket.org/!api/2.0/users/vchaplin"}, "html": {"href": "https://bitbucket.org/vchaplin/"}, "avatar": {"href": "https://bitbucket.org/account/vchaplin/avatar/32/"}}, "extra": {"has_atlassian_account": true}, "created_on": "2014-03-11T16:58:39.397661+00:00", "is_staff": false, "location": null, "type": "user", "uuid": "{3ece6e98-c567-45f5-a3fa-a84b660917ee}"}, "isNavigationOpen": true, "path": "/vchaplin/hifu/src/a6eab5db0d6764b6de7a9f2069e4474a3c404761/code/myPy/numpy.i", "focusedTaskBackButtonUrl": "https://bitbucket.org/vchaplin/hifu/src/a6eab5db0d6764b6de7a9f2069e4474a3c404761/code/myPy/?at=master", "currentUser": {"username": "vchaplin", "website": null, "display_name": "vchaplin", "account_id": "557058:8085dfdf-6e0a-446a-a63b-de16571b5502", "links": {"self": {"href": "https://bitbucket.org/!api/2.0/users/vchaplin"}, "html": {"href": "https://bitbucket.org/vchaplin/"}, "avatar": {"href": "https://bitbucket.org/account/vchaplin/avatar/32/"}}, "extra": {"has_atlassian_account": true}, "created_on": "2014-03-11T16:58:39.397661+00:00", "is_staff": false, "location": null, "type": "user", "uuid": "{3ece6e98-c567-45f5-a3fa-a84b660917ee}"}}, "repository": {"section": {"connectActions": [], "cloneProtocol": "https", "currentRepository": {"scm": "git", "name": "HiFU", "links": {"clone": [{"href": "https://vchaplin@bitbucket.org/vchaplin/hifu.git", "name": "https"}, {"href": "ssh://git@bitbucket.org/vchaplin/hifu.git", "name": "ssh"}], "self": {"href": "https://bitbucket.org/!api/2.0/repositories/vchaplin/hifu"}, "html": {"href": "https://bitbucket.org/vchaplin/hifu"}, "avatar": {"href": "https://bitbucket.org/vchaplin/hifu/avatar/32/"}}, "full_name": "vchaplin/hifu", "owner": {"username": "vchaplin", "website": null, "display_name": "vchaplin", "account_id": "557058:8085dfdf-6e0a-446a-a63b-de16571b5502", "links": {"self": {"href": "https://bitbucket.org/!api/2.0/users/vchaplin"}, "html": {"href": "https://bitbucket.org/vchaplin/"}, "avatar": {"href": "https://bitbucket.org/account/vchaplin/avatar/32/"}}, "created_on": "2014-03-11T16:58:39.397661+00:00", "is_staff": false, "location": null, "type": "user", "uuid": "{3ece6e98-c567-45f5-a3fa-a84b660917ee}"}, "type": "repository", "slug": "hifu", "uuid": "{2192b3b5-9ae6-4fc5-b8a0-e2c9dbf5605d}"}, "menuItems": [{"analytics_label": "repository.overview", "icon_class": "icon-overview", "badge_label": null, "weight": 100, "url": "/vchaplin/hifu/overview", "tab_name": "overview", "can_display": true, "label": "Overview", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-overview-link", "icon": "icon-overview"}, {"analytics_label": "repository.source", "icon_class": "icon-source", "badge_label": null, "weight": 200, "url": "/vchaplin/hifu/src", "tab_name": "source", "can_display": true, "label": "Source", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-source-link", "icon": "icon-source"}, {"analytics_label": "repository.commits", "icon_class": "icon-commits", "badge_label": null, "weight": 300, "url": "/vchaplin/hifu/commits/", "tab_name": "commits", "can_display": true, "label": "Commits", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-commits-link", "icon": "icon-commits"}, {"analytics_label": "repository.branches", "icon_class": "icon-branches", "badge_label": null, "weight": 400, "url": "/vchaplin/hifu/branches/", "tab_name": "branches", "can_display": true, "label": "Branches", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-branches-link", "icon": "icon-branches"}, {"analytics_label": "repository.pullrequests", "icon_class": "icon-pull-requests", "badge_label": "0 open pull requests", "weight": 500, "url": "/vchaplin/hifu/pull-requests/", "tab_name": "pullrequests", "can_display": true, "label": "Pull requests", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-pullrequests-link", "icon": "icon-pull-requests"}, {"analytics_label": "site.addon", "icon_class": "aui-iconfont-build", "badge_label": null, "weight": 550, "url": "/vchaplin/hifu/addon/pipelines-installer/home", "tab_name": "repopage-qgBegL-add-on-link", "can_display": true, "label": "Pipelines", "anchor": true, "analytics_payload": {}, "icon_url": null, "type": "connect_menu_item", "id": "repopage-qgBegL-add-on-link", "target": "_self"}, {"analytics_label": "issues", "icon_class": "icon-issues", "badge_label": "0 active issues", "weight": 600, "url": "/vchaplin/hifu/issues?status=new&status=open", "tab_name": "issues", "can_display": true, "label": "Issues", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-issues-link", "icon": "icon-issues"}, {"analytics_label": "repository.downloads", "icon_class": "icon-downloads", "badge_label": null, "weight": 800, "url": "/vchaplin/hifu/downloads/", "tab_name": "downloads", "can_display": true, "label": "Downloads", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-downloads-link", "icon": "icon-downloads"}, {"analytics_label": "site.addon", "icon_class": "aui-iconfont-unfocus", "badge_label": null, "weight": 100, "url": "/vchaplin/hifu/addon/bitbucket-trello-integration-installer/trello-board", "tab_name": "repopage-74Mgx6-add-on-link", "can_display": true, "label": "Boards", "anchor": false, "analytics_payload": {}, "icon_url": "https://bitbucket-assetroot.s3.amazonaws.com/add-on/icons/35ceae0c-17b1-443c-a6e8-d9de1d7cccdb.svg?Signature=gWC8d8H3cAKTC%2Fx44KTIubEXFOg%3D&Expires=1501179856&AWSAccessKeyId=AKIAIQWXW6WLXMB5QZAQ&versionId=3oqdrZZjT.HijZ3kHTPsXE6IcSjhCG.P", "type": "connect_menu_item", "id": "repopage-74Mgx6-add-on-link", "target": "_self"}, {"analytics_label": "repository.settings", "icon_class": "icon-settings", "badge_label": null, "weight": 100, "url": "/vchaplin/hifu/admin", "tab_name": "admin", "can_display": true, "label": "Settings", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-settings-link", "icon": "icon-settings"}], "bitbucketActions": [{"analytics_label": "repository.clone", "icon_class": "icon-clone", "badge_label": null, "weight": 100, "url": "#clone", "tab_name": "clone", "can_display": true, "label": "<strong>Clone<\/strong> this repository", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-clone-button", "icon": "icon-clone"}, {"analytics_label": "repository.create_branch", "icon_class": "icon-create-branch", "badge_label": null, "weight": 200, "url": "/vchaplin/hifu/branch", "tab_name": "create-branch", "can_display": true, "label": "Create a <strong>branch<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-create-branch-link", "icon": "icon-create-branch"}, {"analytics_label": "create_pullrequest", "icon_class": "icon-create-pull-request", "badge_label": null, "weight": 300, "url": "/vchaplin/hifu/pull-requests/new", "tab_name": "create-pullreqs", "can_display": true, "label": "Create a <strong>pull request<\/strong>", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-create-pull-request-link", "icon": "icon-create-pull-request"}, {"analytics_label": "repository.compare", "icon_class": "aui-icon-small aui-iconfont-devtools-compare", "badge_label": null, "weight": 400, "url": "/vchaplin/hifu/branches/compare", "tab_name": "compare", "can_display": true, "label": "<strong>Compare<\/strong> branches or tags", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-compare-link", "icon": "aui-icon-small aui-iconfont-devtools-compare"}, {"analytics_label": "repository.fork", "icon_class": "icon-fork", "badge_label": null, "weight": 500, "url": "/vchaplin/hifu/fork", "tab_name": "fork", "can_display": true, "label": "<strong>Fork<\/strong> this repository", "anchor": true, "analytics_payload": {}, "target": "_self", "type": "menu_item", "id": "repo-fork-link", "icon": "icon-fork"}], "activeMenuItem": "source"}}};
  window.__settings__ = {"SOCIAL_AUTH_ATLASSIANID_LOGOUT_URL": "https://id.atlassian.com/logout", "CANON_URL": "https://bitbucket.org", "API_CANON_URL": "https://api.bitbucket.org"};
</script>

<script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/jsi18n/en/djangojs.js"></script>

  <script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/dist/webpack/locales/en.js"></script>

<script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/dist/webpack/vendor.js"></script>
<script src="https://d301sr5gafysq2.cloudfront.net/d47e46547a06/dist/webpack/app.js"></script>


<script async src="https://www.google-analytics.com/analytics.js"></script>

<script type="text/javascript">window.NREUM||(NREUM={});NREUM.info={"beacon":"bam.nr-data.net","queueTime":0,"licenseKey":"a2cef8c3d3","agent":"","transactionName":"Z11RZxdWW0cEVkYLDV4XdUYLVEFdClsdAAtEWkZQDlJBGgRFQhFMQl1DXFcZQ10AQkFYBFlUVlEXWEJHAA==","applicationID":"1841284","errorBeacon":"bam.nr-data.net","applicationTime":1256}</script>
</body>
</html>