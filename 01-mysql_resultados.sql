SELECT * FROM h2.clientes;
describe h2.clientes;
SELECT * FROM h2.resultado;
select 
	id 
	,data_nascimento
	,case 
		when YEAR(data_nascimento) between 1925 and 1940 then 'Veteranos'
		when YEAR(data_nascimento) between 1941 and 1959 then 'BabyBoomers'
		when YEAR(data_nascimento) between 1960 and 1979 then 'GeracaoX'
		when YEAR(data_nascimento) between 1980 and 1995 then 'GeracaoY'
		when YEAR(data_nascimento) between 1996 and 2010 then 'GeracaoZ'
		when YEAR(data_nascimento) > 2010 then 'Alpha'
		else 'Erro'
	end as Geracao
from h2.clientes;



-- =====================================================
-- 		1 - Usando SQL para responder perguntas
-- =====================================================

-- a. Quanto de rake foi gerado por cada Geração* de jogadores?
-- Rake: o lucro da empresa com esse jogador.
select b.geracao, sum(a.rake) as TotalRake 
from resultado a
inner join clientes b ON a.clientes_id = b.id 
group by b.Geracao
order by TotalRake desc;

/*
# geracao, TotalRake
'GeracaoY', '612313.4099803176'
'GeracaoX', '520623.2700801641'
'GeracaoZ', '93276.51005220227'
'BabyBoomers', '38547.06000582501'
'Erro', '2.6000000834465027'

*/



-- b. Qual foi o rake gerado por mês?
select DATE_FORMAT(data_acesso, '%m') AS mes, sum(rake) TotalRakeMes
from h2.resultado
group by  DATE_FORMAT(data_acesso, '%m')
order by DATE_FORMAT(data_acesso, '%m');
/*
mes, TotalRakeMes
01, 115018.2900201045
02, 133456.0700326208
03, 150940.57996613532
04, 179483.96997165866
05, 89826.83995525911
06, 75980.51005028561
07, 69081.07002633624
08, 87251.4300332889
09, 90846.91994152404
10, 82759.46008542553
11, 93242.83008826151
12, 96874.87994769216
*/




-- c. Qual sexo tem uma maior proporção de ganhadores**?
select b.sexo, sum(a.winning) as TotalWinning
from resultado a
inner join clientes b ON a.clientes_id = b.id 
where a.winning > 0 
group by b.sexo
order by 2 desc;

/*
sexo	TotalWinning
m	1.842,695,7241325974
	184.808,33145857975
f	154.912,2701630965
*/

