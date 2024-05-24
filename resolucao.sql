-- 1. Histórico escolar de qualquer aluno

SELECT * FROM alunos;

SELECT D.Nome as NomeDisciplina, T.Ano, T.Semestre, M.NotaFinal
FROM Matriculas M
JOIN Turmas T ON M.TurmaID = T.TurmaID
JOIN Disciplinas D ON T.DisciplinaID = D.DisciplinaID
WHERE M.AlunoID = 1;  -- Substitua '?' pelo ID do aluno

-- 2. Histórico de disciplinas ministradas por qualquer professor

SELECT D.Nome as NomeDisciplina, T.Ano, T.Semestre
FROM Turmas T
JOIN Disciplinas D ON T.DisciplinaID = D.DisciplinaID
WHERE T.ProfessorID = 1;  -- Substitua '?' pelo ID do professor

-- 3. Listar alunos que já se formaram em um determinado semestre de um ano

SELECT A.AlunoID, A.Nome
FROM Alunos A
WHERE NOT EXISTS (
    SELECT *
    FROM MatrizCurricular MC
    JOIN Cursos C ON MC.CursoID = C.CursoID
    WHERE MC.CursoID = (
        SELECT C.CursoID
        FROM Matriculas M
        JOIN Turmas T ON M.TurmaID = T.TurmaID
        JOIN Disciplinas D ON T.DisciplinaID = D.DisciplinaID
        JOIN MatrizCurricular MC ON MC.DisciplinaID = D.DisciplinaID
        WHERE M.AlunoID = A.AlunoID AND M.NotaFinal < 6
        GROUP BY C.CursoID
    )
);

-- 4. Listar todos os professores que são chefes de departamento, junto com o nome do departamento

SELECT P.Nome as NomeProfessor, D.Nome as NomeDepartamento
FROM Professores P
JOIN Departamentos D ON P.ProfessorID = D.ChefeID;

-- 5. Saber quais alunos formaram um grupo de TCC e qual professor foi o orientador

SELECT G.GrupoID, A.Nome as NomeAluno, P.Nome as NomeOrientador
FROM GruposTCC G
JOIN MembrosTCC MT ON G.GrupoID = MT.GrupoID
JOIN Alunos A ON MT.AlunoID = A.AlunoID
JOIN Professores P ON G.OrientadorID = P.ProfessorID;

