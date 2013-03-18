@admin  = { name: 'Krugloff' }

@client  = @admin.merge name: 'John'
@no_name = @admin.except :name