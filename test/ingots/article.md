Это тестовая статья. Статьи будут поступать в формате Markdown и сохраняться в HTML. Весь посторонний HTML код будет удален.

## HTML

'<script>
  $('body').replaceWith '<img src=bad_img.jpeg>'
</script>'

Ссылка в формате <a href='www.bad_site.com'>HTML</a>.

## Markdown

### Заголовок

**Выделенный текст**

_Курсив_

Ссылка: [Google](www.google.com)

Однострочный код: `article.title = 'Welcome!'`

Дословный текст:
```
  article = Article.new
  article.save
```

Код на ruby:
```ruby
class Article < ActiveRecord::Base
  attr_accessible :title, :body

  # before_save :body_to_html

  has_many :comments
  belongs_to :user

  validates :title,
    presence: true,
    length: { maximum: 42 },
    format: { with: /^[[:print:]]+$/ }

  validates :body, :user,
    presence: true

  private

  def body_to_html
    syntax = Redcarpet::Render::Krugloff.new filter_html: true
    parser = Redcarpet::Markdown.new syntax,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_spacing: true
    self.body = parser.render(body)
  end
end
```

Код на erlang:
```erlang
  %% quicksort:qsort(List)
  %% Sort a list of items
  -module(quicksort).
  -export([qsort/1]).

  qsort([]) -> [];
  qsort([Pivot|Rest]) ->
  qsort([ X || X <- Rest, X < Pivot]) ++ [Pivot] ++ qsort([ Y || Y <- Rest, Y >= Pivot])
```
Маркированный список:

+ Первый пункт;
+ Второй пункт.

Нумерованный список:

1. Первый пункт;
2. Второй пункт.