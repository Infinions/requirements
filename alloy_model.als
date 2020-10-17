sig Orcamento{}

sig Categoria{
	orcamento: lone Orcamento
}

sig Etiqueta{}

sig Utilizador{}

sig Fatura{
	categoria: one Categoria,
	etiquetas: set Etiqueta
}

sig Empresa{
	utilizadores: set Utilizador,
	faturas: set Fatura
}

sig Sistema {
	empresas: set Empresa,
}
----------------------------------------------------------------
fact init {
	one Sistema
	no Sistema.empresas
	no Empresa.utilizadores
	no Empresa.faturas
	no Fatura.categoria
	no Fatura.etiquetas
	no Categoria.orcamento
}

fact {
	no Categoria implies no Orcamento
}

fact {
	no Fatura implies (no Categoria and no Etiqueta)
}

fact {
	no Empresa implies (no Utilizador and no Fatura)
}

fact {
	Empresa = Sistema.empresas and
	Utilizador = Empresa.utilizadores and
	Fatura = Empresa.faturas and
	Categoria = Fatura.categoria and
	Etiqueta = Fatura.etiquetas and
	Orcamento = Categoria.orcamento
}

-- Add fact to execute the predicates
-------------------------------------------------------------
pred addEmpresa [e : Empresa] {
	some Sistema

	Empresa = Empresa + e
}

pred addFatura [f : Fatura] {
	some Empresa

	Fatura = Fatura + f
}

pred addOrcamento [o : Orcamento] {
	some Categoria

	Orcamento = Orcamento + o
}

pred addCategoria [c : Categoria] {
	some Fatura

	Categoria = Categoria + c
}

pred addEtiqueta [e : Etiqueta] {
	some Fatura

	Etiqueta = Etiqueta + e
}

pred addUtilizador [u : Utilizador] {
	some Empresa

	Utilizador = Utilizador + u
}





