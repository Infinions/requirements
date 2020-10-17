sig User {} {
	one e : Company | this in e.users -- users must be associated with ONE company
}

sig Tag {} {
	one e : Company | this in e.tags -- tags must be associated with ONE company
}

sig Category {
	budget: lone Budget
} {
	Category = Company.categories -- categories must be associated with a company
     	one e : Company | this in e.categories -- categories must be associated with ONE company
}

sig Budget {} {
	Budget = Category.budget -- budgets must be associated with a category
}

sig Company {
	users: set User,
	categories: set Category,
	tags: set Tag
}

sig Invoice {
	company: one Company,
	category: lone Category,
	tags: set Tag
}

fact "invoice tags must be tags from the company" {
	all i : Invoice | i.tags in i.company.tags
}

fact "invoice categories must be categories from the company" {
	all i : Invoice | i.category in i.company.categories
}

fact "a company must have a least one user" {
	all e : Company | some e.users
}

fact "budgests aren't shared" {
	all disj c, d : Category | c.budget != d.budget
}

run { } for 4

check UsersBelongToOnlyOneCompany {
	all disj e1, e2 : Company | no e1.users & e2.users
}

check TagsBelongToOnlyOneCompany" {
	all disj e1, e2 : Company | no e1.tags & e2.tags
}

check CategoriesBelongToOnlyOneCompany" {
	all disj e1, e2 : Company | no e1.categories & e2.categories
}



