#encoding: utf-8

@valid =  { provider: 'development',
            user: users('valid') }

@blank_uid      = @valid.except :uid
@blank_provider = @valid.merge provider: ''
@no_user        = @valid.except :user
