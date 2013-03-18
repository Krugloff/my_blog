@new =  { title: 'Welcome to my blog!',
          body: File.read('test/ingots/article.md') }

@invalid_new =  { title: '?' * 257,
                  body: File.read('test/ingots/article.md') }

@valid  = @new.merge user: users('admin')

@blank_title  = @valid.merge title: ''
@blank_body   = @valid.merge title: ''
@big_title    = @valid.merge title: "?" * 257
@no_user      = @valid.except :user
