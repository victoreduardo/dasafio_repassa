# Cargos
TbCargo.create(nome: 'DBA', salario: 10000)
TbCargo.create(nome: 'DevOps', salario: 11000)
TbCargo.create(nome: 'UX', salario: 11000)
TbCargo.create(nome: 'Developer', salario: 11000)
TbCargo.create(nome: 'Gerente', salario: 15000)

# Simple User
empregado1 = TbEmpregado.new(nome: 'Colaborador 1 Gerente', nmr_cpf: '201.369.370-20', end_email: 'gerente@admin.com', dta_nascimento: '01/01/2000',
                             sexo: :masculino, dta_admissao: '01/01/2020', tb_cargo_id: TbCargo.find_by(chave: :gerente)&.id)
empregado1.save

# Simple User
empregado2 = TbEmpregado.new(nome: 'Colaborador 2 Developer', nmr_cpf: '287.379.430-57', end_email: 'developer@admin.com', dta_nascimento: '01/01/2000',
                             sexo: :masculino, dta_admissao: '01/01/2020', tb_cargo_id: TbCargo.find_by(chave: :developer)&.id)
empregado2.save

# Admin User
empregado3 = TbEmpregado.new(nome: 'Colaborador 3 Adm', nmr_cpf: '136.708.700-75', end_email: 'admin@admin.com', dta_nascimento: '01/01/2000',
                             sexo: :masculino, dta_admissao: '01/01/2020', tb_cargo_id: TbCargo.find_by(chave: :developer)&.id,
                             e_admin: true)
empregado3.save

# Simple User
empregado4 = TbEmpregado.new(nome: 'Colaborador 2 UX', nmr_cpf: '478.812.830-68', end_email: 'ux@admin.com', dta_nascimento: '01/01/2000',
                             sexo: :feminino, dta_admissao: '01/01/2020', tb_cargo_id: TbCargo.find_by(chave: :ux)&.id)
empregado4.save

# Simple User
empregado5 = TbEmpregado.new(nome: 'Colaborador 2 DevOps', nmr_cpf: '807.740.570-33', end_email: 'devops@admin.com', dta_nascimento: '01/01/2000',
                             sexo: :feminino, dta_admissao: '01/01/2020', tb_cargo_id: TbCargo.find_by(chave: :devops)&.id)
empregado5.save

