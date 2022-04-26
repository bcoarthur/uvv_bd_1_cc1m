su -

psql -U postgres

create user arthur superuser createdb createrole inherit login password '12345';

\c uvv arthur

create schema if not exists elmasri authorization arthur;

alter user arthur
set earch_path to elmasri, "\$user", public;

CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11) NOT NULL,
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE funcionario IS 'Tabela utilizada para armazenar os dados pessoais dos funcionários.';
COMMENT ON COLUMN funcionario.cpf IS 'Essa coluna é a chave primária da tabela funcionário, nela ficam armazenados os cpf''s dos funcionários.';
COMMENT ON COLUMN funcionario.primeiro_nome IS 'Essa coluna armazena o primeiro nome do funcionário.';
COMMENT ON COLUMN funcionario.nome_meio IS 'Essa coluna armazena o segundo nome do funcionário, que deve ser escrito de forma abreviada, apenas com a primeira letra.';
COMMENT ON COLUMN funcionario.ultimo_nome IS 'Essa coluna armazena o ultimo nome do funcionário.';
COMMENT ON COLUMN funcionario.data_nascimento IS 'Essa coluna armazena a data de nascimento do funcionário.';
COMMENT ON COLUMN funcionario.endereco IS 'Essa coluna armazena o endereço do funcionário.';
COMMENT ON COLUMN funcionario.sexo IS 'Essa coluna armazena o sexo do funcionário.';
COMMENT ON COLUMN funcionario.salario IS 'Essa coluna armazena o salário do funcionário.';
COMMENT ON COLUMN funcionario.cpf_supervisor IS 'Essa coluna armazena o cpf do supervisor do funcionário e é uma chave estrangeira que se relaciona com a coluna cpf.funcionario.';
COMMENT ON COLUMN funcionario.numero_departamento IS 'Essa coluna armazena o número do departamento que o funcionário faz parte.';


CREATE TABLE departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE departamento IS 'Essa tabela armazena as informações do departamento.';
COMMENT ON COLUMN departamento.numero_departamento IS 'Essa coluna armazena o numero de indentificação do departamento e é a chave primária da tabela.';
COMMENT ON COLUMN departamento.nome_departamento IS 'Essa coluna armazena o nome do departamento e é uma chave única.';
COMMENT ON COLUMN departamento.cpf_gerente IS 'Essa coluna armazena o cpf do gerente e é uma chave estrangeira para a tabela funcionário.';
COMMENT ON COLUMN departamento.data_inicio_gerente IS 'Essa coluna armazena a data de inicio de trabalho do gerente.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE projeto IS 'Essa tabela armazena as informações sobre o projeto.';
COMMENT ON COLUMN projeto.numero_projeto IS 'Essa coluna armazena o número do projeto e é a chave primária da tabela.';
COMMENT ON COLUMN projeto.nome_projeto IS 'Essa coluna armazena o nome do projeto e é uma chave única.';
COMMENT ON COLUMN projeto.local_projeto IS 'Essa coluna armazena a localização aonde é desenvolvido o projeto.';
COMMENT ON COLUMN projeto.numero_departamento IS 'Essa coluna armazena o numero de indentificação do departamento e é uma chave estrangeira para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE TABLE localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE localizacoes_departamento IS 'Essa tabela armazena a localização dos departamentos.';
COMMENT ON COLUMN localizacoes_departamento.numero_departamento IS 'Essa coluna armazena o numero de indentificação do departamento. E é uma chave primária dessa tabela.';
COMMENT ON COLUMN localizacoes_departamento.local IS 'Essa coluna armazena o local onde se encontra o departamento. E junto com a coluna numero_departamento formam uma superchave.';


CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE trabalha_em IS 'Essa tabela armazena informações sobre o trabalho do funcionário.';
COMMENT ON COLUMN trabalha_em.cpf_funcionario IS 'Essa coluna armazena o cpf do funcionário, é uma chave primária e ao mesmo tempo uma chave estrangeira da tabela funcionário.';
COMMENT ON COLUMN trabalha_em.numero_projeto IS 'Essa coluna armazena o numero do projeto, é uma chave primária e tambem é uma chave estrangeira da tabela projeto.';
COMMENT ON COLUMN trabalha_em.horas IS 'Essa coluna armazena as horas de trabalho do funcionário.';


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE dependente IS 'Essa tabela armazena as informações do dependente do funcionário.';
COMMENT ON COLUMN dependente.cpf_funcionario IS 'Essa coluna armazena o cpf do funcionário que além de ser a chave primária da tabela, é uma chave estrangeira para a tabela funcionário.';
COMMENT ON COLUMN dependente.nome_dependente IS 'Essa coluna armazena o nome do dependente. E é uma chave primária, junto com cpf_funcionario.dependente, assim formando uma superchave.';
COMMENT ON COLUMN dependente.sexo IS 'Essa coluna armazena o sexo do dependente.';
COMMENT ON COLUMN dependente.data_nascimento IS 'Essa coluna armazena a data de nascimento do dependente.';
COMMENT ON COLUMN dependente.parentesco IS 'Essa coluna armazena o grau de parentesco que o dependente tem com o funcionário.';


ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;
