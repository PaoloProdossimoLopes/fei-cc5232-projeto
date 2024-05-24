-- Criação da tabela de Departamentos
CREATE TABLE Departamentos (
    DepartamentoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    ChefeID INT
    -- A chave estrangeira será adicionada após a criação da tabela Professores
);

-- Criação da tabela de Professores
CREATE TABLE Professores (
    ProfessorID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    DataNascimento DATE,
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

-- Adicionando a chave estrangeira para ChefeID após a criação de Professores
ALTER TABLE Departamentos
ADD CONSTRAINT fk_chefe
FOREIGN KEY (ChefeID) REFERENCES Professores(ProfessorID);

-- Criação da tabela de Cursos
CREATE TABLE Cursos (
    CursoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    Duracao INT
);

-- Criação da tabela de Disciplinas
CREATE TABLE Disciplinas (
    DisciplinaID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    DepartamentoID INT,
    FOREIGN KEY (DepartamentoID) REFERENCES Departamentos(DepartamentoID)
);

-- Criação da tabela de MatrizCurricular
CREATE TABLE MatrizCurricular (
    MatrizID SERIAL PRIMARY KEY,
    CursoID INT,
    DisciplinaID INT,
    SemestreRecomendado INT,
    FOREIGN KEY (CursoID) REFERENCES Cursos(CursoID),
    FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(DisciplinaID)
);

-- Criação da tabela de Turmas
CREATE TABLE Turmas (
    TurmaID SERIAL PRIMARY KEY,
    DisciplinaID INT,
    ProfessorID INT,
    Ano INT,
    Semestre INT,
    FOREIGN KEY (DisciplinaID) REFERENCES Disciplinas(DisciplinaID),
    FOREIGN KEY (ProfessorID) REFERENCES Professores(ProfessorID)
);

-- Criação da tabela de Alunos
CREATE TABLE Alunos (
    AlunoID SERIAL PRIMARY KEY,
    Nome VARCHAR(255),
    DataNascimento DATE,
    Matricula VARCHAR(100)
);

-- Criação da tabela de Matriculas
CREATE TABLE Matriculas (
    AlunoID INT,
    TurmaID INT,
    NotaFinal DECIMAL(5,2),
    PRIMARY KEY (AlunoID, TurmaID),
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID),
    FOREIGN KEY (TurmaID) REFERENCES Turmas(TurmaID)
);

-- Criação da tabela de GruposTCC
CREATE TABLE GruposTCC (
    GrupoID SERIAL PRIMARY KEY,
    Tema VARCHAR(255),
    OrientadorID INT,
    FOREIGN KEY (OrientadorID) REFERENCES Professores(ProfessorID)
);

-- Criação da tabela de MembrosTCC
CREATE TABLE MembrosTCC (
    GrupoID INT,
    AlunoID INT,
    PRIMARY KEY (GrupoID, AlunoID),
    FOREIGN KEY (GrupoID) REFERENCES GruposTCC(GrupoID),
    FOREIGN KEY (AlunoID) REFERENCES Alunos(AlunoID)
);
