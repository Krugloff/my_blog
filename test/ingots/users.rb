@valid  = { name: 'Krugloff' }

@not_admin  = @valid.merge name: 'John'
@no_name = @valid.except :name