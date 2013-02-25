#coding: utf-8

@new =  { title: "Хорошая цитата",
          body: "**Путь программиста** - это осознание существующих абстракций и создание еще более абстрактных абстракций." }

@invalid_new = @new.merge title: '?' * 257

@valid  = @new.merge  user: users('valid'),
                      article: articles('valid')

@blank_body   = @valid.merge body: ''
@big_title    = @valid.merge title: '?' * 257
@no_article   = @valid.merge article: nil
@no_user      = @valid.merge user: nil