@valid  = { name: 'Krugloff',
            password: 'a11ri9ht',
            password_confirmation: 'a11ri9ht' }

@not_admin = @valid.merge name: 'John'

@blank_name     = @valid.merge name: ''
@big_name       = @valid.merge name: '?' * 257
@small_name     = @valid.merge name: 'xx'
@not_uniq       = @valid.merge password: 'dreams'
@blank_password = @valid.merge password: ''
