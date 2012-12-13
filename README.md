# Twitter Bootstrap for Rails 3
Make [Twitter Bootstrap](http://twitter.github.com/bootstrap) into Rails Engine. [Bootstrap-datepicker](https://github.com/eternicode/bootstrap-datepicker) is also included.

## Version
Bootstrap 2.2.2
Bootstrap-datepicker (2012/12/13)

## Rails 3.1 or later
Include Gemfile,

    gem 'bootstrap-rails-engine'

Add stylesheets into application.css

    *= require bootstrap/bootstrap
    *= require bootstrap/bootstrap-responsive

Add javascripts into application.js

    //= require bootstrap/bootstrap

## CDN

This gem supports cdn the same as [jquery-rails-cdn](https://github.com/yjchen/jquery-rails-cdn). In the application layout, add

    = bootstrap_javascript_include_tag :default

and 

    = bootstrap_stylesheet_include_tag :default

then remove corresponding lines in application.js and application.css.

## License

Copyright (c) 2012 Yen-Ju Chen

MIT License

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
