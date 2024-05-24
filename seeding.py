import psycopg2
from faker import Faker
import random

fake = Faker()

# Dados para conexão com o banco de dados PostgreSQL
# Substitua pelos seus dados de conexão
host = "seu_host"
dbname = "seu_dbname"
user = "seu_user"
password = "sua_senha"
port = "5432"  # Porta padrão do PostgreSQL

# Conexão com o banco de dados
conn = psycopg2.connect(
    host=host,
    dbname=dbname,
    user=user,
    password=password,
    port=port
)
cur = conn.cursor()

# Geração e inserção de dados para Professores
for _ in range(10):
    nome = fake.name()
    data_nascimento = fake.date_of_birth(minimum_age=30, maximum_age=70)
    departamento_id = random.randint(1, 5)  # Assumindo que existem 5 departamentos
    cur.execute('INSERT INTO Professores (Nome, DataNascimento, DepartamentoID) VALUES (%s, %s, %s)', 
                (nome, data_nascimento, departamento_id))

# Geração e inserção de dados para Departamentos
departamentos = ['Ciências Exatas', 'Ciências Humanas', 'Engenharia', 'Medicina', 'Direito']
for i, depto in enumerate(departamentos, start=1):
    chefe_id = i  # Simplesmente associando o chefe ao seu ID de professor para exemplo
    cur.execute('INSERT INTO Departamentos (Nome, ChefeID) VALUES (%s, %s)', (depto, chefe_id))

# Geração e inserção de dados para Alunos
for _ in range(50):
    nome = fake.name()
    data_nascimento = fake.date_of_birth(minimum_age=18, maximum_age=30)
    matricula = fake.unique.lexify(text='?????????')
    cur.execute('INSERT INTO Alunos (Nome, DataNascimento, Matricula) VALUES (%s, %s, %s)', 
                (nome, data_nascimento, matricula))

# Salva (commit) as transações
conn.commit()

# Fechamento da conexão com o banco de dados
cur.close()
conn.close()

print("Dados inseridos com sucesso.")
