@valid  = { name: 'Krugloff' }

@not_admin  = @valid.merge name: 'John'
@blank_name = @valid.merge name: ''