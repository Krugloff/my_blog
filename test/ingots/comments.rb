@new =  { body: "**Путь программиста** - это осознание существующих абстракций и создание еще более абстрактных абстракций." }

@invalid_new = @new.merge body: ''

@valid  = @new.merge  user: users('admin'),
                      article: articles('valid')

@blank_body   = @valid.merge body: ''
@no_article   = @valid.except :article
@no_user      = @valid.except :user