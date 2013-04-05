@new = { body: "**Путь программиста** - это осознание существующих абстракций и создание еще более абстрактных абстракций." }

@invalid_new = @new.merge body: ''

@valid = @new.merge user: users('admin'),
                    article: articles('valid')

@child = @valid.merge parent_id: 1

@blank_body   = @valid.merge body: ''
@no_article   = @valid.except :article
