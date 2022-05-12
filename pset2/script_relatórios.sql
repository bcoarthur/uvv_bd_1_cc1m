use uvv;

-- QUESTÃO 1

select avg(func.salario) as media_salarial,
dep.nome_departamento
from funcionario func
join departamento dep
on dep.numero_departamento = func.numero_departamento
group by dep.nome_departamento;

-- QUESTÃO 2

select avg(salario) as media_salarial,
sexo
from funcionario
group by sexo;

-- QUESTÃO 3

select dep.nome_departamento,
concat (func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
func.data_nascimento,
timestampdiff(year, data_nascimento, now()) as idade_atual,
func.salario
from departamento dep
join funcionario func
on dep.numero_departamento = func.numero_departamento
order by dep.nome_departamento;

-- QUESTÃO 4

select concat (primeiro_nome," ",
nome_meio," ",
ultimo_nome) as nome_completo,
timestampdiff(year, data_nascimento, now()) as idade_atual,
salario,
cast((salario * 1.2) as decimal(10,2)) as salario_reajustado
from funcionario
where salario < "35000"

union

select concat (primeiro_nome," ",
nome_meio," ",
ultimo_nome) as nome_completo,
timestampdiff(year, data_nascimento, now()) as idade_atual,
salario,
cast((salario * 1.15) as decimal(10,2)) as salario_reajustado
from funcionario
where salario >= "35000";

-- QUESTÃO 5

select dep.nome_departamento,
gerente.primeiro_nome as gerente,
func.primeiro_nome,
salario
from departamento dep
join funcionario func,

(select primeiro_nome,
cpf
from funcionario func
join departamento dep
where func.cpf = dep.cpf_gerente) as gerente

where dep.numero_departamento = func.numero_departamento
and
gerente.cpf = dep.cpf_gerente

order by dep.nome_departamento asc,
func.salario desc;

-- QUESTÃO 6

select concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
dep.nome_departamento,
depen.nome_dependente,
timestampdiff(year, depen.data_nascimento, now()) as idade_atual_dependente,
case when depen.sexo = 'M' then 'masculino' when depen.sexo = 'm' then 'masculino'
when depen.sexo = 'F' then 'feminino' when depen.sexo = 'f' then 'feminino' end as sexo_dependente
from funcionario func
join departamento dep
on func.numero_departamento = dep.numero_departamento
join dependente depen
on depen.cpf_funcionario = func.cpf;

-- QUESTÃO 7

select distinct concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
dep.nome_departamento,
cast((func.salario) as decimal (10,2)) as salario
from funcionario func
join departamento dep
join dependente depen
where dep.numero_departamento = func.numero_departamento
and
func.cpf not in
(select depen.cpf_funcionario
from dependente depen);

-- QUESTÃO 8

select dep.nome_departamento,
pjt.nome_projeto,
concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
trab.horas
from funcionario func
join departamento dep
join projeto pjt
join trabalha_em trab
where dep.numero_departamento = func.numero_departamento
and
pjt.numero_projeto = trab.numero_projeto
and
func.cpf = trab.cpf_funcionario
order by pjt.numero_projeto; 

-- QUESTÃO 9

select dep.nome_departamento,
pjt.nome_projeto,
sum(trab.horas) as total_de_horas
from departamento dep
join projeto pjt
join trabalha_em trab
where dep.numero_departamento = pjt.numero_departamento
and
pjt.numero_projeto = trab.numero_projeto
group by pjt.nome_projeto;

-- QUESTÃO 10

select avg(func.salario) as media_salarial,
dep.nome_departamento
from funcionario func
join departamento dep
on dep.numero_departamento = func.numero_departamento
group by dep.nome_departamento;

