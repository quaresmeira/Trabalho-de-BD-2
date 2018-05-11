CREATE FUNCTION fn_tabelaDes (@prova VARCHAR(100), @bateria VARCHAR(20), @fase VARCHAR(20))
	RETURNS @tabelaDesempenho table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado DECIMAL(7,2)
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)
		SET @codb=(SELECT id FROM bateria WHERE nome=@bateria)

		INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,pcs.resultado FROM prova_cs pcs 
		INNER JOIN prova p
		ON pcs.cod_prova=p.cod
		INNER JOIN fase f
		ON pcs.cod_fase=f.id
		INNER JOIN bateria b
		ON pcs.cod_bateria=b.id
		INNER JOIN atleta atl
		ON pcs.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf AND b.id=@codb 
	RETURN
END
	
select * FROM dbo.fn_tabelaDes('Lançamento de Dado / Javelin Throw','1ºCiclo','FINAL') as tabela

CREATE FUNCTION fn_tabelaCorrida (@prova VARCHAR(100), @fase VARCHAR(20))
	RETURNS @tabelaDesempenho table (
		Codigo INT,
		Nome VARCHAR(100),
		Pais VARCHAR(50),
		Resultado DATETIME
	)
BEGIN
	DECLARE @codp INT,
			@codb INT,
			@codf INT
		SET @codp = (SELECT cod FROM prova WHERE prova=@prova)
		SET @codf =(SELECT id FROM fase WHERE nome=@fase)

		INSERT INTO @tabelaDesempenho(Codigo,Nome,Pais,Resultado)
		SELECT atl.cod,atl.nome,ps.nome,pc.resultado FROM prova_corrida pc 
		INNER JOIN prova p
		ON pc.cod_prova=p.cod
		INNER JOIN fase f
		ON pc.cod_fase=f.id
		INNER JOIN atleta atl
		ON pc.cod_atleta=atl.cod
		INNER JOIN pais ps
		ON atl.cod_pais=ps.cod
		WHERE
		p.cod=@codp AND f.id=@codf
	RETURN
END