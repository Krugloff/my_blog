#encoding: utf-8

@admin =  { uid: '1234567890',
            provider: 'developer',
            user: users('admin') }

@client = @admin.merge uid: '12345', user: users('client')

@no_uid         = @admin.except :uid
@blank_provider = @admin.merge provider: ''
@no_user        = @admin.except :user
