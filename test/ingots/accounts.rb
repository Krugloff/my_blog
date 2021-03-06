@new =  { uid: '1234567890',
          provider: 'developer',
          name: 'Krugloff' }

@admin  = @new.merge user: users('admin')
@client = @admin.merge uid: '12345', user: users('client')

@no_uid         = @admin.except :uid
@blank_provider = @admin.merge provider: ''
@no_name        = @admin.except :name