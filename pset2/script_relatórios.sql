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

