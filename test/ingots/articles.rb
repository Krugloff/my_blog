@new =  { title: 'Welcome to my blog!',
          body: File.read('test/ingots/article.md') }

@valid  = @new.merge user: users('admin')

@blank_title  = @valid.merge title: ''
@blank_body   = @valid.merge body: ''
@big_title    = @valid.merge title: '?' * 43