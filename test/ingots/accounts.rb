#encoding: utf-8

@valid =  { uid: 1234567890,
            provider: 'developer',
            user: users('valid') }

@no_uid         = @valid.except :uid
@blank_provider = @valid.merge provider: ''
@no_user        = @valid.except :user
