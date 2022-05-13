-- Usar o código abaixo inicialmente para que todo o restante seja executado com êxito

use uvv;

-- RELATÓRIO 1

select avg(func.salario) as media_salarial,
dep.nome_departamento
from funcionario func
join departamento dep
on dep.numero_departamento = func.numero_departamento
group by dep.nome_departamento;

-- RELATÓRIO 2

select avg(salario) as media_salarial,
sexo
from funcionario
group by sexo;

-- RELATÓRIO 3

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

-- RELATÓRIO 4

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

-- RELATÓRIO 5

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

-- RELATÓRIO 6

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

-- RELATÓRIO 7

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

-- RELATÓRIO 8

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

-- RELATÓRIO 9

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

-- RELATÓRIO 10

select avg(func.salario) as media_salarial,
dep.nome_departamento
from funcionario func
join departamento dep
on dep.numero_departamento = func.numero_departamento
group by dep.nome_departamento;

-- RELATÓRIO 11

select concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
pjt.nome_projeto,
cast((func.salario) as decimal(10,2)) as receberá
from funcionario func
join projeto pjt
join trabalha_em trab
where func.cpf = trab.cpf_funcionario
and
pjt.numero_projeto = trab.numero_projeto
group by func.primeiro_nome;

-- RELATÓRIO 12

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
where func.cpf = trab.cpf_funcionario
and
pjt.numero_projeto = trab.numero_projeto
and
(trab.horas = 0 or trab.horas = null)
group by func.primeiro_nome;

-- RELATÓRIO 13

select concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
case when sexo = 'M' then 'masculino' when sexo = 'm' then 'masculino'
when sexo = 'f' then 'feminino' when sexo = 'f' then 'feminino' end as sexo,
timestampdiff(year, func.data_nascimento, now()) as idade_atual
from funcionario func

union

select dep.nome_dependente,
case when sexo = 'M' then 'masculino' when sexo = 'm' then 'masculino'
when sexo = 'F' then 'Feminino' when sexo = 'f' then 'Feminino' end as sexo,
timestampdiff(year, dep.data_nascimento, now()) as idade_atual
from dependente dep 
order by idade_atual;

-- RELATÓRIO 14

select dep.nome_departamento,
count(func.numero_departamento) as quantidade_funcionarios
from funcionario func
join departamento dep
where func.numero_departamento = dep.numero_departamento 
group by dep.nome_departamento;

-- RELATÓRIO 15

select distinct concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
dep.nome_departamento, 
pjt.nome_projeto
from departamento dep
join projeto pjt
join trabalha_em trab
join funcionario func 
where dep.numero_departamento = func.numero_departamento 
and 
pjt.numero_projeto = trab.numero_projeto 
and
trab.cpf_funcionario = func.cpf

union

select distinct concat(func.primeiro_nome,' ',
func.nome_meio,' ',
func.ultimo_nome) as nome_completo,
dep.nome_departamento, 
'sem projeto' as projeto
from departamento dep
join projeto pjt
join trabalha_em trab
join funcionario func 
where dep.numero_departamento = func.numero_departamento 
and 
pjt.numero_projeto = trab.numero_projeto 
and
(func.cpf not in (select trab.cpf_funcionario from trabalha_em trab));



