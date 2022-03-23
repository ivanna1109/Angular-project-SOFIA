-- MySQL dump 10.13  Distrib 8.0.20, for Win64 (x86_64)
--
-- Host: localhost    Database: baza_nwp
-- ------------------------------------------------------
-- Server version	8.0.20

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `izdavac`
--

DROP TABLE IF EXISTS `izdavac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `izdavac` (
  `idIzdavac` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(45) NOT NULL,
  `adresa` varchar(50) NOT NULL,
  `telefon` varchar(30) NOT NULL,
  PRIMARY KEY (`idIzdavac`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `izdavac`
--

LOCK TABLES `izdavac` WRITE;
/*!40000 ALTER TABLE `izdavac` DISABLE KEYS */;
INSERT INTO `izdavac` VALUES (1,'Sofia','Bulevar Evrope 32, Novi Sad','021/11-09-099'),(2,'Vulkan','Sremska 2, Beograd','011/45-40-900'),(3,'Laguna','Kralja Petra 45, Beograd','011/71-55-055'),(4,'Prometej','Svetozara Miletića 16, Novi Sad','0800/323-323'),(5,'Mladinska knjiga','Omladinskih brigada 102, Novi Beograd','011/22-57-035 ');
/*!40000 ALTER TABLE `izdavac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategorija`
--

DROP TABLE IF EXISTS `kategorija`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategorija` (
  `idKategorija` int NOT NULL AUTO_INCREMENT,
  `nazivKategorije` varchar(50) NOT NULL,
  PRIMARY KEY (`idKategorija`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorija`
--

LOCK TABLES `kategorija` WRITE;
/*!40000 ALTER TABLE `kategorija` DISABLE KEYS */;
INSERT INTO `kategorija` VALUES (1,'klasici'),(2,'ljubavni'),(3,'trileri'),(4,'horor'),(5,'istorijski'),(6,'biografija'),(7,'drama'),(8,'fantastika'),(9,'komedija'),(10,'poezija');
/*!40000 ALTER TABLE `kategorija` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `kategorija_has_knjiga`
--

DROP TABLE IF EXISTS `kategorija_has_knjiga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `kategorija_has_knjiga` (
  `Kategorija_idKategorija` int NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  PRIMARY KEY (`Kategorija_idKategorija`,`Knjiga_idKnjiga`),
  KEY `fk_Kategorija_has_Knjiga_Knjiga1_idx` (`Knjiga_idKnjiga`),
  KEY `fk_Kategorija_has_Knjiga_Kategorija1_idx` (`Kategorija_idKategorija`),
  CONSTRAINT `fk_Kategorija_has_Knjiga_Kategorija1` FOREIGN KEY (`Kategorija_idKategorija`) REFERENCES `kategorija` (`idKategorija`),
  CONSTRAINT `fk_Kategorija_has_Knjiga_Knjiga1` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `kategorija_has_knjiga`
--

LOCK TABLES `kategorija_has_knjiga` WRITE;
/*!40000 ALTER TABLE `kategorija_has_knjiga` DISABLE KEYS */;
INSERT INTO `kategorija_has_knjiga` VALUES (5,1),(6,1),(6,2),(6,3),(6,4),(6,5),(6,6),(7,7),(8,8),(8,9),(8,10),(4,11),(4,12),(4,13),(5,14),(1,15),(1,16),(1,17),(1,18),(1,19),(2,20),(9,20),(7,21),(9,21),(9,22),(9,23),(9,24),(2,25),(5,25),(7,25),(2,26),(7,26),(2,27),(7,27),(2,28),(10,29),(10,30),(10,31),(10,32),(10,33),(3,34),(4,34),(3,35),(3,36),(3,37),(7,38);
/*!40000 ALTER TABLE `kategorija_has_knjiga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `knjiga`
--

DROP TABLE IF EXISTS `knjiga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `knjiga` (
  `idKnjiga` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(50) NOT NULL,
  `godinaIzdanja` int NOT NULL,
  `cena` int NOT NULL,
  `brojKnjigaLager` int NOT NULL,
  `akcija` int NOT NULL,
  `kratakOpis` varchar(2000) DEFAULT NULL,
  `slika` varchar(150) DEFAULT NULL,
  `Izdavac_idIzdavac` int NOT NULL,
  `Pisac_idPisac` int NOT NULL,
  PRIMARY KEY (`idKnjiga`),
  KEY `fk_Knjiga_Izdavac1_idx` (`Izdavac_idIzdavac`),
  KEY `fk_Knjiga_Pisac1_idx` (`Pisac_idPisac`),
  CONSTRAINT `fk_Knjiga_Izdavac1` FOREIGN KEY (`Izdavac_idIzdavac`) REFERENCES `izdavac` (`idIzdavac`),
  CONSTRAINT `fk_Knjiga_Pisac1` FOREIGN KEY (`Pisac_idPisac`) REFERENCES `pisac` (`idPisac`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `knjiga`
--

LOCK TABLES `knjiga` WRITE;
/*!40000 ALTER TABLE `knjiga` DISABLE KEYS */;
INSERT INTO `knjiga` VALUES (1,'Austrijanka',2018,680,49,20,'Kasno proleće 1942, gluvo doba noći. Na sporedni kolosek zagrebačke železničke stanice pristiže transport stočnih vagona krcat srpskim ženama. Odlaze na prisilni rad u Nemački Rajh. Pored šina razapet je šator Crvenog krsta. Sredovečna Austrijanka Diana Budisavljević Obekser deli im čaj i nešto hrane. Danima i nedeljama muči je isto pitanje: gde su deca? Ona koja su preživela ustaške pokolje odvojena su od majki i očeva i prepuštena sebi.Posle mnogo traganja Diana Budisavljević saznaje da su u Staroj Gradišci, ispostavi zloglasnog logora Jasenovac. Upornošću i nadljudskim naporom sa grupom svojih saradnica uspeva da prodre u tu fabriku smrti. Tog vrelog letnjeg dana 1942. susreće se s prizorima iz pakla. Vrhovni zapovednik Maks Luburić naređuje joj da hitno napusti logor.','https://www.laguna.rs/_img/korice/4987/austrijanka-zoran_milekic_v.jpg',2,1),(2,'Biti Džon Lenon',2019,950,77,10,'Kako je izgledalo biti Džon Lenon – odbačeno dete, školsko spadalo, dečko srednje klase iz predgrađa, koji je glumio heroja radničke klase? Kakav je bio osećaj imati jedan od najprepoznatljivijih glasova svetske muzike, ali koji vam se toliko ne dopada da ga uvek želite zamaskirati? On je bio duhovit, često urnebesan... Ali pre svega, imao je svoj stav, svoju drskost, koja je oličavala težnje čitave njegove generacije da se suprotstavi autoritetima. Umeo je i želeo da saopšti neizrecivo. Iako je u istoriji rok muzike bilo glamuroznijih zvezda, čak i u okviru samih Bitlsa, pojava Džona Lenona uhvatila je i definisala duh svog vremena na najupečatljiviji način.','https://www.laguna.rs/_img/korice/4327/biti_dzon_lenon-rej_konoli_v.jpg',2,2),(3,'Biti Elvis',2019,950,80,0,'Div u američkoj popularnoj kulturi, božanstvo u istoriji rokenrola, Elvis Presli je spojio gospel i tradicionalni crnački ritam i bluz sa kantrijem da bi stvorio potpuno nov muzički pravac i nov način da se istakne muška seksualnost, i time raspametio puritansku Ameriku pedesetih godina XX veka. U knjizi Biti Elvis novinar Rej Konoli daje svež pogled na karijeru najvoljenijeg pevača na svetu, smeštajući ga, četrdeset godina nakon njegove smrti, ne samo pod drečava neonska svetla Las Vegasa već i na američki Jug sredinom XX veka. Konoli, koji je intervjuisao Elvisa 1969, predstavlja muzičara koji je iz siromaštva u Tupelu u Misisipiju dostigao neviđenu slavu preko noći, Frenka Sinatru smenio sa trona, a zatim inspirisao Bitlse.','https://www.laguna.rs/_img/korice/4846/biti_elvis-rej_konoli_v.jpg',2,2),(4,'Povratak kralja',2018,800,50,0,'Uzbudljivo putovanje kroz gotovo dva veka istorije moderne srpske države, uz upoznavanje sa glavnim ličnostima koje su odredile sudbinu dinastije Karađorđević, posebno njenog poslednjeg vladara. „U knjizi Povratak kralja Luka Mičeta nas vodi kroz istoriju porodice Karađorđević od njenog osnivača „Crnog Đorđa“ i njegove borbe za oslobođenje srpskog naroda od otomanske vlasti do poslednjeg vladara njegove loze, kralja Petra II, i njegovog posthumnog povratka u postojbinu... Ova literarno efektno napisana knjiga lako se čita, događaji se odvijaju i prate sa radoznalošću, pri čemu autor ističe mnogobrojne pojedinosti manje poznate ili sasvim nepoznate široj javnosti.“','https://www.laguna.rs/_img/korice/2126/povratak_kralja-luka_miceta_v.jpg',3,3),(5,'Pink Floyd - Kad svinje polete',2017,890,29,0,'Kad svinje polete je prva kompletna biografija grupe Pink Flojd. Ovo prošireno izdanje istorije jedne od najvećih rok grupa svih vremena nastalo je nakon što je autor Mark Blejk razgovarao sa Dejvidom Gilmorom, Rodžerom Votersom, Ričardom Rajtom i Nikom Mejsonom, i intervjuisao ostale bivše članove grupe, producente, školske drugove, devojke, scenske tehničare, cimere, menadžere, prijatelje, neprijatelje i brojne druge ljude koji su imali uvid u živote članova grupe i njihov rad. Spajajući mišljenja i uspomene očevidaca, ova knjiga prati priču grupe počev od njenih korena u Kembridžu do globalnog uspeha albumom The Dark Side Of the Moon i gorkog raspada osamdesetih godina XX veka, od njihovog istorijskog okupljanja na „Lajv ejtu“ do smrti osnivača Sida Bareta 2006. i sve nakon toga.','https://www.laguna.rs/_img/korice/3379/kad_svinje_polete-mark_blejk_v.jpg',1,4),(6,'Stefan Nemanja',2016,850,20,0,'Povest Srba od doseljavanja na Balkan do države župana Stefana Nemanje. Povest Srba od doseljavanja na Balkan do države župana Stefana Nemanje. Stefan Nemanja, u monaštvu Simeon, spada u one vladare koji su stekli poštovanje kako svojih podanika i savremenika, tako i svojih potomaka. Samo je uticaj njegovog svetiteljskog kulta na srpski narod bio veći od njegove vladarske slave. Monah sveti Simeon je nadvisio i nadmašio velikog župana Stefana Nemanju. Vladarski plašt zamenio je skromnom monaškom rizom, mač krstom, štit jevanđeljem, veseli i bučni dvor hilandarskom tišinom. Silazeći sa trona peo se u večnost. Bilo je to izdizanje iznad ljudske mere – na putu ka svetosti.','https://www.laguna.rs/_img/korice/2316/stefan_nemanja_v.jpg',3,3),(7,'Ada',2020,1100,17,0,'Roman Mome Kapora Ada, prvi put objavljen davne 1977. godine u biblioteci „Hit“, vrlo je brzo doživeo brojna izdanja i na taj način potvrdio veliku popularnost ovog autora. Novo Lagunino izdanje pruža mogućnost onima koji se do sada nisu sreli sa književnošću Mome Kapora da se upoznaju sa prozom jednog od najčitanijih pisaca ovog podneblja. Ilustracije autora prate knjigu i zaokružuju priču o reci Savi i neobičnim stanovnicima njenih obala.','https://www.laguna.rs/_img/korice/4921/ada-momo_kapor_v.jpg',3,27),(8,'Prolaz - I tom',2016,1000,20,0,'Nakon noći u kojoj vladaju haos i krvoproliće osvanuće dan koji će zauvek izmeniti lice planete. Malobrojni preživeli osuđeni su na dugu borbu i budućnost u kojoj vlada strah – od mraka, od smrti, od još gore sudbine. Nakon što se civilizacija u trenu sunovrati i ponovo nastupi doba predatora i plena, dvoje ljudi otpočinje potragu za utočištem – Bred Volgast, agent FBI-ja koji je progonjen onim što je činio na dužnosti, i šestogodišnje siroče Ejmi Harper Belafonte, odbegla iz naučne ustanove iz koje je poteklo apokaliptično zlo. Odlučan da je zaštiti od užasa koje su u svet pustili njeni tamničari, pomoći će joj da otpočne odiseju u kojoj će Ejmi morati da okonča ono što nikada nije smelo da se desi.','https://www.laguna.rs/_img/korice/1474/prolaz_i_tom-dzastin_kronin_v.jpg',1,7),(9,'Prolaz - II tom',2016,1000,20,0,'Nakon noći u kojoj vladaju haos i krvoproliće osvanuće dan koji će zauvek izmeniti lice planete. Malobrojni preživeli osuđeni su na dugu borbu i budućnost u kojoj vlada strah – od mraka, od smrti, od još gore sudbine.\n\nNakon što se civilizacija u trenu sunovrati i ponovo nastupi doba predatora i plena, dvoje ljudi otpočinje potragu za utočištem – Bred Volgast, agent FBI-ja koji je progonjen onim što je činio na dužnosti, i šestogodišnje siroče Ejmi Harper Belafonte, odbegla iz naučne ustanove iz koje je poteklo apokaliptično zlo. Odlučan da je zaštiti od užasa koje su u svet pustili njeni tamničari, pomoći će joj da otpočne odiseju u kojoj će Ejmi morati da okonča ono što nikada nije smelo da se desi.','https://www.laguna.rs/_img/korice/1475/prolaz_ii_tom-dzastin_kronin_v.jpg',1,7),(10,'Grozničavi san',2020,1500,30,0,'Kada Abner Marš, propali rečni kapetan i brodovlasnik, dobije ponudu da se uortači s bogatim aristokratom, posumnjaće da tu nešto smrdi. A kada se upozna sa avetinjski bledim Džošuom Jorkom, čovekom čeličnosivih očiju, znaće da je bio u pravu. Jer Jorka nije briga što je ledena zima 1857. zbrisala gotovo sve Maršove brodove s lica zemlje. Nije ga briga ni što mu se uloženi novac neće vratiti ni za deset godina. Jork ima sopstvene razloge što želi da proputuje silnu reku Misisipi uzduž i popreko, i ti razlozi ne treba da se tiču Marša – ma koliko da su Jorkovi postupci naizgled bizarni, proizvoljni ili hiroviti.\nMarš ima nameru da odbije Jorkovu ponudu. Iza nje se krije suviše tajni i sve sluti na opasnost. Ipak, zlato je zlato, uz to mu se pruža prilika da sagradi nov brod koji bi mogao ući u istoriju – a tu je i zastrašujuća žestina Jorkovog neodoljivog pogleda. Tek u toku prve plovidbe Marš shvata da se upustio u nešto zlokobnije, ali možda i plemenitije nego što je mogao da pretpostavi.','https://www.laguna.rs/_img/korice/4882/groznicavi_san-dzordz_r_r_martin_v.jpg',3,6),(11,'Deca noći',2016,900,48,0,'Ovaj klasični roman o vampirima, sa uvodom Dena Simonsa posebno napisanim za ovo izdanje, povešće vas na mesto koje niko ne poznaje – ali kojeg se svi bojimo.\nU oronulom sirotištu u postkomunističkoj Rumuniji teško bolesna beba greškom dobija transfuziju krvi – iako svi očekuju da će umreti, ona počinje da se oporavlja i razvija. Doktorka Kejt Nojman pomišlja da detetov imuni sistem možda krije tajnu leka za rak i sidu. Kejt usvaja bebu i vodi je sa sobom u Ameriku. Međutim, mali Džošua je povezan sa jednim drevnim plemenom i njegovim legendarnim vođom – Vladom Cepešom, prvobitnim Drakulom – čiji će ga ljudi kidnapovati. Uprkos nemogućim izgledima i surovim neprijateljima – i ljudskim i vampirskim – Kejt i njen saveznik, otac Majk O\'Rurk, krišom se vraćaju u Rumuniju ne bi li spasili dete.','https://www.laguna.rs/_img/korice/3002/deca_noci-den_simons_v.jpg',4,8),(12,'Stan br. 16',2014,800,50,0,'Ovaj klasični roman o vampirima, sa uvodom Dena Simonsa posebno napisanim za ovo izdanje, povešće vas na mesto koje niko ne poznaje – ali kojeg se svi bojimo.\nU oronulom sirotištu u postkomunističkoj Rumuniji teško bolesna beba greškom dobija transfuziju krvi – iako svi očekuju da će umreti, ona počinje da se oporavlja i razvija. Doktorka Kejt Nojman pomišlja da detetov imuni sistem možda krije tajnu leka za rak i sidu. Kejt usvaja bebu i vodi je sa sobom u Ameriku. Međutim, mali Džošua je povezan sa jednim drevnim plemenom i njegovim legendarnim vođom – Vladom Cepešom, prvobitnim Drakulom – čiji će ga ljudi kidnapovati. Iza vrata stana br. 16 krije se užas. \nU Berington hausu, u stambenoj četvrti u Londonu, jedan stan je prazan. U njega niko ne ulazi, iz njega niko ne izlazi. I tako je već pedeset godina, sve dok noćni čuvar posle ponoći ne čuje neku buku – a onda će doživeti nešto što će mu zauvek promeniti život.\nU zgradu stiže mlada Amerikanka Ejpril. Nasledila je stan od tajanstvene baba-tetke Lilijan, koja je umrla pod neobičnim okolnostima. Priča se da je Lilijan bila luda. Ali njen dnevnik ukazuje na to da je pre više decenija bila umešana u niz užasnih i neobjašnjivih događaja.Rešena da sazna nešto više o toj ekscentričnoj ženi, Ejpril počinje da naslućuje šta je tajna koju krije Berington haus i otkriva da nekakvo preobraženo zlo još uvek boravi u zgradi. A vrata stana broj 16 prolaz su ka nečem još užasnijem...Uprkos nemogućim izgledima i surovim neprijateljima – i ljudskim i vampirskim – Kejt i njen saveznik, otac Majk O\'Rurk, krišom se vraćaju u Rumuniju ne bi li spasili dete.','https://www.laguna.rs/_img/korice/2432/stan_br_16-adam_nevil_v.jpg',4,10),(13,'Peščana hronika',2013,800,50,0,'Na radnoj akciji izgradnje Novog Beograda, nekoliko godina posle Drugog svetskog rata, pet pionira, ponesenih duhom udarništva, otkriće jedan nepoznat svet i steći priliku da se u njemu dokažu. Pored žestokog rada, naučiće kako da vezuju pertle, da čitaju i pišu, da se zaljube, a otkriće i zlokobnu pretnju iz bliske prošlosti koja vreba ispod peska i mulja močvare – budućeg novog grada.Pedeset godina kasnije, Ilija Orlović, novopečeni debeovac, a odnedavno i udovac i samohrani otac, u bekstvu pred odgovornošću koja ga može koštati života, sakriće se u lavirintu novobeogradskih blokova. Baš na mestu koje sve ove decenije prati ista kletva. Na prividno sasvim običnom dečjem igralištu ušuškanom u nedrima zgrade u kojoj je našao sklonište, pod budnim očima stanara, staraca koji čuvaju tajnu, Ilija će otkriti novu šansu za već okrnjeno detinjstvo svog šestogodišnjeg sina. A odmah zatim i neverovatne opasnosti, namerno zakopane i zaboravljene. Ilija će morati da zaviri kroz pukotine istorije i osloni se na neočekivane saveznike kako bi spasao sina i iskupio samog sebe. Jer pod temeljima peščanog grada krije se zlo koje odbija da potone u zaborav...','https://www.laguna.rs/_img/korice/2134/pescana_hronika-pavle_zelic_v.jpg',4,9),(14,'Istanbulska lala',2019,1000,30,0,'Nakon šest hiljada godina svog postojanja Vizantion, Konstantinopolj, Istanbul ili samo Grad, sada, u prvoj polovini XVII veka, svedok je kraja ere lala. Otomansko carstvo je na prekretnici, međunarodne granice se menjaju, ekscentrična aristokratija stvara sve veće podele u društvu, a siromašni su još siromašniji. Istanbul je centar previranja i pobune.\nU uskomešanom gradu dva mladića su u potrazi za ljubavlju. Da bi stekli naklonost devojaka, odlučuju da iskoriste poslednju šansu i obogate se tako što će se domoći lukovice neprocenjivo vredne lale. No, da bi se njihov plan ostvario, moraju da reše ko je počinio brutalno ubistvo i šezdeset šest zagonetki misterioznog cveta. Dok u svoju priču upliće mnoštvo istorijskih i folklornih detalja, Iskender Pala tka očaravajuću tapiseriju sjaja i poroka Istanbula, vodi nas od sultanovog dvora i derviških loža do kafana i hamama, kroz svet intriga, zavera, ljubavnog zanosa.','https://www.laguna.rs/_img/korice/4372/istanbulska_lala-iskender_pala_v.jpg',1,11),(15,'Evgenije Onjegin',2020,1350,78,0,'Onjegin i Lenski predstavljaju dva tipa mladih obrazovanih plemića čija je tragična sudbina posledica raskoraka između njihovih želja i sposobnosti i života koji vode. Kod Lenskog je uzrok razočaranja i nesreće idealizovanje stvarnosti koja nikad nije bila onakva kakvom ju je pesnik zamišljao dok je kod Onjegina taj sukob zasnovan na dubokim unutrašnjim protivrečnostima.\n\nLik Onjegina poslužio je kao uzor čitavoj galeriji tipova, takozvanih „suvišnih ljudi“, kao što su Ljermontovljev Pečorin ili Turgenjevljev Ruđin. S druge strane, jedina koja je u Puškinovom romanu svoju nesreću primila dostojanstveno, ne gubeći ni u jednom trenutku ravnotežu i dodir sa običnim narodom, bila je Tatjana, prva u nizu nezaboravnih junakinja moderne ruske književnosti.','https://www.laguna.rs/_img/korice/4989/evgenije_onjegin-aleksandar_puskin_v.jpg',2,12),(16,'Idiot - I tom',2019,1550,80,0,'Nakon nekoliko godina provedenih u švajcarskom sanatorijumu, knez Lav Nikolajevič Miškin vraća se u Petrograd. Polako se ponovo uključuje u visoko društvo, kojim vladaju novac, moć i romantične intrige. Dobronameran i naivan, knez Miškin će se naći u ljubavnom trouglu sa mladom i lepom Aglajom Jepančinom i zloglasnom Nastasjom Filipovnom. Međutim, njegov čisto estetski doživljaj ženske lepote bez ikakve primese seksualnih želja u velikoj meri uzrokovaće drame u njihovim odnosima.\nU suprotnosti sa ostatkom sveta, njegova bezazlenost i gotovo detinja iskrenost od Miškina će načiniti najpozitivnijeg ali i najneprilagođenijeg junaka Fjodora Dostojevskog. \n','https://www.laguna.rs/_img/korice/4432/idiot_i_tom-fjodor_mihailovic_dostojevski_v.jpg',2,28),(17,'Idiot - II tom',2019,1550,80,0,'Čime ćete spasti svet i u čemu ste za njega našli pravi put, vi, ljudi nauke, industrije, trustova, nadnica i ostalog? Čime? Kreditom? Šta je kredit? Čemu će vas kredit dovesti?\n\nKnez Miškin je antipod svih onih gordih likova Dostojevskog kojima je glavni strah u životu da ne ispadnu smešni pred drugima – od Goljatkina iz Dvojnika, preko junaka Zapisa iz podzemlja, do zelenaša iz Krotke. On je uspeo da u sebi potisne i najmanji znak samoljublja i dospeo do smirenosti kao najvišeg cilja. U liku kneza Miškina Dostojevski je hteo da prikaže apsolutno dobrog čoveka, a predočio je tragediju nesvakidašnjeg junaka.','https://www.laguna.rs/_img/korice/4433/idiot_ii_tom-fjodor_mihailovic_dostojevski_v.jpg',2,28),(18,'Majstor i Margarita',2020,1150,50,0,'Tridesetih godina prošlog veka u Moskvu stiže đavo. Ubrzo po dolasku, ovaj neočekivani posetilac sa svojim pomoćnicima, među kojima su i jedan mačor koji govori i prelepa veštica, unosi pometnju kod Moskovljana koji odbijaju da veruju kako u Boga tako i u đavola. U međuvremenu, Majstor, autor neobjavljenog rukopisa o Isusu Hristu i Pontiju Pilatu, očajan leži u psihijatrijskoj bolnici. Njemu odana Margarita toliko ga voli da je zarad njega spremna da đavolu proda dušu.\nPo mnogo čemu jedinstven u ruskoj književnosti, ovaj roman obiluje humorom i filozofskom dubinom. Zbog cenzure i aluzija na Staljinovu diktaturu je ovo vrhunsko delo Mihaila Bulgakova u celosti objavljeno bezmalo tri decenije posle piščeve smrti. Danas je osvedočeno blago svetske književnosti. ','https://www.laguna.rs/_img/korice/4628/majstor_i_margarita-mihail_bulgakov_v.jpg',2,14),(19,'Znakovi pored puta',2018,1300,60,0,'Neiscrpno vrelo mudrosti, „Znakovi pored puta“ već skoro pola veka omiljeno su štivo mnogih generacija, knjiga koja se sa podjednakim uživanjem može čitati gde god se otvori, riznica najraznolikijih saveta, zapažanja i životnih uvida koje je ovaj pisac upućivao ne samo čitaocima nego i samome sebi.\n\nPosebna vrednost ovog Laguninog izdanja su prevodi pojedinih izreka i citata stranih pisaca koje je Andrić u originalu na nemačkom, latinskom, francuskom i dr. jezicima unosio u svoju fasciklu, a koje u dosadašnjim izdanjima ovog osobenog dela nisu prevedeni.\n','https://www.laguna.rs/_img/korice/4984/znakovi_pored_puta-ivo_andric_v.jpg',3,15),(20,'Bogomdana domaćica',2018,950,15,0,'Samanta je poznati londonski advokat. Radi po ceo dan, nema privatnog života i jedino joj je važno da postane jedan od partnera u svojoj firmi. Uživa u gužvi i adrenalinu. Sve dok jednog dana... ne pogreši. Ta greška je tako strašna da će joj uništiti karijeru.\nPotpuno rastrojena, Samanta napušta kancelariju, ulazi u prvi voz koji naiđe i odlazi bogu iza nogu. Kad na pragu jedne velike, lepe kuće zastane da se raspita za pravac, vlasnici greškom pomisle da se javila na oglas i nude joj posao domaćice. Nemaju pojma da su zaposlili pravnika s Kembridža čiji je koeficijent inteligencije 158 i koji ne ume čak ni pećnicu da uključi. Na pomolu je katastrofa. Samanta se bori s mašinom za pranje rublja, s daskom za peglanje, pokušava da spremi kordon ble za večeru... Ali možda ona i nije takav antitalenat za kućne poslove kao što je mislila. Možda će, uz malu pomoć, uspeti. Hoće li njeni poslodavci otkriti da je ona zapravo vrhunski advokat? Hoće li Samanta ikad moći da se vrati svom nekadašnjem životu? A i ako bude mogla... hoće li to želeti? Ovo je priča o devojci koja mora malo da uspori korak. Da pronađe sebe. Da se zaljubi. I da otkrije čemu služi pegla...','https://www.laguna.rs/_img/korice/559/bogomdana_domacica-sofi_kinsela_v.jpg',1,16),(21,'Čovek po imenu Uve',2017,1050,40,0,'Upoznajte Uvea. On je džangrizalo – jedan od onih koji upiru prstom u ljude koji mu se ne dopadaju kao da su provalnici zatečeni pod njegovim prozorom. Svakog jutra Uve ide u inspekciju po naselju u kom živi. Premešta bicikle i proverava da li je đubre pravilno razvrstano – iako je već nekoliko godina prošlo otkako je razrešen dužnosti predsednika kućnog saveta. Ili otkako je „izvršen prevrat“, kako Uve govori o tome. Ljudi ga zovu „ogorčenim komšijom iz pakla“. Ali zar Uve mora da bude ogorčen samo zbog toga što ne šeta okolo sa osmehom zalepljenim na lice? Međutim, iza njegove mrzovolje i pedanterije skriva se jedna priča i mnogo tuge... I tako, kada komšije koje se useljavaju u susednu kuću jednog novembarskog dana slučajno unište Uveovo poštansko sanduče, iznenada počinje topla priča o odrpanim mačkama, neočekivanom prijateljstvu i drevnoj veštini vožnje auta sa prikolicom. Priča koja će suštinski promeniti jednog čoveka i jedno udruženje stanara.','https://www.laguna.rs/_img/korice/3366/covek_po_imenu_uve_v.jpg',1,17),(22,'Sećaš me se?',2017,850,40,0,'Leksi se budi u bolničkom krevetu posle saobraćajne nezgode misleći da je 2004, da joj je dvadeset pet godina, da ima krive zube i da nema sreće u ljubavi. Ali, na svoje zaprepašćenje, shvata da je zapravo 2007. – i da joj je dvadeset osam godina, da su joj zubi savršeni, da je postala šef u firmi – i da je udata! I to za zgodnog milionera! Kako se, za ime sveta, našla u tom bajkovitom životu? Ona prosto ne može da poveruje u svoju sreću – naročito kad ugleda svoj predivni novi dom. Sigurna je da će, pošto ponovo upozna svog muža, imati savršen brak. On joj je čak napisao i „bračni priručnik“, koji bi trebalo da joj pomogne u tome. Međutim, dok upoznaje svoju novu ličnost, u njenom savršenom životu pojavljuju se pukotine. Svi njeni stari prijatelji je mrze. Konkurenti žele da joj preotmu posao. A zatim se pojavljuje i jedan razbarušeni, seksi momak... sa novim šokantnim vestima.Šta joj se, do vraga, desilo? Hoće li se ikad setiti? I šta će biti kad se seti?','https://www.laguna.rs/_img/korice/908/secas_me_se-sofi_kinsela_v.jpg',1,16),(23,'Umeš li da čuvaš tajnu? ',2005,800,40,0,'Junakinja romana Umeš li da čuvaš tajnu?, dvadesetpetogodišnja Ema Korigan, kao i valjda svaka devojka na svetu, ima vrlo malo tajni. Dobro, nije da ih nema, ali nisu to bogzna kako krupne tajne, od onih što će izmeniti svet... Jednoga dana, u hamletovskom trenu, sedeći u avionu koji svaki čas može da se sruši, ona će i poslednji tajnoviti delić svoga života otkriti potpunom strancu. Ispostavlja se da je misteriozni neznanac čovek bez koga ovaj roman ne bi dobio zaplet – on je vlasnik kompanije za koju Ema radi, vrlo važna faca. Gazda sada zna sve, ali baš sve o njoj, do poslednjeg intimnog detalja: i kakav donji veš nosi, i kako je izgubila nevinost, i šta stvarno misli o momku za koga će se, po svemu sudeći, uskoro udati...\n','https://www.laguna.rs/_img/korice/309/umes_li_da_cuvas_tajnu-sofi_kinsela_v.jpg',1,16),(24,'Uznemireni ljudi',2020,1100,50,0,'Tokom razgledanja stana koji se nudi na prodaju jedan propali pljačkaš banke zaključaće se s iritantno entuzijastičnim agentom za prodaju nekretnina, dvojicom ogorčenih zavisnika od Ikee, trudnicom, samoubilački nastrojenim multimilionerom i prokletim zecom. Kada policija konačno bude upala u stan, zateći će ga... praznog. A onda se taoci jave policiji sa svojim beskorisnim iskazima i saznajemo šta se stvarno dogodilo. Ili ne? Jer najveće zagonetke i dalje su pred nama. Kako je pljačkaš uspeo da pobegne? Zašto su svi tako besni? I šta je NAOPAKO s ljudima ovih dana?\n','https://www.laguna.rs/_img/korice/4609/uznemireni_ljudi-fredrik_bakman_v.jpg',5,17),(25,'Nevesta plantažera čaja',2020,1100,50,0,'Saga o ljubavi mlade žene u Indiji dvadesetih godina prošlog veka. Sofi je sa šest godina ostala siroče i sa plantaže čaja njenih roditelja u Indiji odveli su je kod tetke u Škotsku gde je odrastala. Mirisi, boje i sećanja iz detinjstva ostali su duboko u njoj i kad je postala mlada, buntovna devojka koja voli da izlazi i vozi motor, što je bilo neuobičajeno i smelo dvadesetih godina prošlog veka. Zahvaljujući svojoj rođaci Tili, koja će se udati i poći u Indiju, i simpatičnim momcima Tamu i Rafiju, koje je upoznala na jednoj od svojih vožnji, Sofi će se vratiti u Indiju, u svet svog detinjstva. No Indija je u to vreme bila daleko od bajkovite zemlje iz sećanja. Džungle su previše vlažne, plantaže čaja daleko u brdima, a Tam će oboleti od malarije.Sofi je suočena s mnogim izazovima. Pred njom se otvaraju tajne o misterioznoj smrti njenih roditelja. Osećanja su joj pomešana i nova ljubav koja se rađa stavlja je pred teške odluke. Spletke moćnih ljudi prete da unište sve za šta se borila. Hoće li ova mlada, lepa i emancipovana žena umeti da pronađe pravi put do ostvarenja svojih snova?\n','https://www.laguna.rs/_img/korice/4759/nevesta_plantazera_caja-dzenet_maklaud_troter_v.jpg',5,18),(26,'Noći u Rodanteu',2018,790,50,0,'Ovo je nežna priča o nadi i radosti, o žrtvovanju i oproštaju – dirljiv podsetnik na to da je ljubav moguća u svim životnim dobima i da nam se uglavnom desi onda kad je najmanje očekujemo. Četrdesetpetogodišnja Ejdrijen Vilis mora da preispita svoj život pošto ju je muž ostavio zbog mlađe žene. Slomljenog srca i u potrazi za predahom, beži u malo primorsko mesto Rodante, u Severnoj Karolini, da preko vikenda pripazi na gostionicu svoje prijateljice. Najava velike oluje, međutim, preti da joj upropasti savršeno smišljeno bekstvo – barem dok ne stigne gost po imenu Pol Flener.Pedesetčetvorogodišnji Pol je upravo prodao svoju lekarsku praksu i došao je u Rodante da i sam pobegne od prošlosti. I sad, dok se bliži oluja, dvoje povređenih ljudi okreću se jedno drugome radi utehe – i tokom samo jednog vikenda među njima se bude osećanja koja će u oboma odzvanjati do kraja života.\n','https://www.laguna.rs/_img/korice/3800/noci_u_rodanteu-nikolas_sparks_v.jpg',5,19),(27,'Ringišpil',2010,1200,68,0,'„Njeni pokreti bili su tananiji i suptilniji od svake note. Njeno telo je sinonim za strast i umetnost istovremeno. Elegancija, lirska izražajnost, emocije i gracioznost u sebi nose jedno ime: Ana Balint. Znala je da voli njega, jedinog, strasnom, dubokom, čistom, nemerljivom ljubavlju. Sve druge ljubavi u njenom životu bile su blede replike tog nikada zaboravljenog osećaja bliskosti, tog pripadanja drugoj duši, u kojoj se njena ogledala, tih neizrecivo tananih i nežnih emocija.“Jelena Bačić Alimpić ispisuje intimnu povest balerine krhkog tela i džinovskog duha koji je ostavio pečat na svim slavnim baletskim scenama, gradeći istovremeno priču o malim-velikim ljudima, salašarima i umetnicima, pesnicima i njihovim muzama, senovitim bačkim salašima i gradićima, jutrima koja mirišu na slatko od dunja i nezaboravnim ruskim zimama....\n','https://www.laguna.rs/_img/korice/1407/ringispil-jelena_bacic_alimpic__v.jpg',1,20),(28,'Tiha Žena',2020,1090,70,0,'U kancelariji ugledne londonske advokatske firme pojavila se žena u prljavoj odeći, koja je visila s njenog krhkog tela, a bilo je očigledno da ima teškoće s govorom. Kad je gospodin Armstrong, advokat, saznao ime posetiteljke, shvatio je da će razrešiti tajnu koja ga je mučila dvadeset šest godina. Ajrin Bejndor, Tiha Žena, nekad je bila mlada i fina, muzički nadarena supruga bogatog i moćnog čoveka i majka voljenog sina. Šta se dogodilo s njom? Šta je radila i gde je bila tokom svih tih godina? Gde je nestao njen divan glas? Uz izuzetnu veštinu u smišljanju zapleta, smeštanju radnje i slikanju likova i uz oslanjanje na vlastito iskustvo života radničke klase, Ketrin Kukson nas vodi kroz nesvakidašnju priču o životu Tihe Žene.\n','https://www.laguna.rs/_img/korice/4812/tiha_zena-ketrin_kukson_v.jpg',1,29),(29,'Garavi sokak',2020,890,18,0,'Miroslav Antić posvećuje ovu knjigu mladom Ciganinu Miletu Dileji, koga su fašisti jedne noći odveli i streljali. Sahranjen je 1942. blizu Pančeva u zajedničku grobnicu bezimenih žrtava. Otuda ova romantična himna o čoveku među zvezdama neprekidno odzvanja i zvukom speva protiv genocidnosti.\nGaravi sokak je tinjajući venac slika o odrastanju i prebogatoj nemaštini, o bolnoj sreći i gutanju sudbine, o alhemiji tuge i kosmičkoj radosti. Bogata potresnim lirskim obrtima, ovo je jedinstvena zbirka u opusu originalnog pesnika.','https://www.laguna.rs/_img/korice/4648/garavi_sokak-miroslav_antic_v.jpg',5,30),(30,'Plavi čuperak',2015,890,20,0,'Svako u sebi nosi tajnu svoje budućnosti. Za Miroslava Antića ona je plava, nevina, beskonačna, nebeska i zvezdana.\nPlavi čuperak je najlepši priručnik za odrastanje i nezaobilazni zapis o drhtanju onih koji su se zaljubili prvi put. Ova vanvremena zbirka pesama za samo pola veka postala je predivni udžbenik čežnje, jedinstveno uputstvo za beskrajno čuvanje detinjstva u nama, neodoljivi spomenik šašavosti, dnevnik sa čijih stranica osećamo sazvučja daljina ka kojima hrlimo...','https://www.laguna.rs/_img/korice/2878/plavi_cuperak-miroslav_antic_v.jpg',5,30),(31,'Pepeo dogorelih krila',2020,890,20,0,'Pepeo dogorelih krila je izbor pesama i kratke proze koji prati istoriju literarnog i intimnog života. Tekstovi Miroslava Antića – od naizgled prozračnih i veselih pesama za decu, preko mladalačkih, ljubavnih, porodičnih, pa sve do onih ironičnih i mračnih – ulančani su tako da pokazuju kako se njegov poetski ciklus ne može odvojiti od životnog, što pridružuje vojvođanskog barda posebnoj vrsti književnih velikana – onih koji nisu poetizovali svoj život već su živeli svoju poeziju...','https://www.laguna.rs/_img/korice/4723/pepeo_dogorelih_krila-miroslav_antic_v.jpg',4,30),(32,'O dukatu s likom starca',2020,1100,30,0,'Poezija govori sama o sebi i svaki govor o njoj je ne doseže. Postoji samo reč – ostalo je naklapanje. U najnovijoj duhovnoj obnovi srpskog pesništva sve uočljiviji je stvaralački poduhvat Selimira Radulovića o čijem čitanju i razumevanju one jedne jedine knjige iz koje su nastale sve ostale kao da svedoče i njegovi inicijali.\nS. R. u Bibliji nalazi odgovore na dileme savremenog čoveka i tek iskrsla pitanja naših dana. Svojim pesništvom S. R. demantuje mišljenje da ta knjiga kod Srba uopšte i u srpskom pesništvu posebno nije imala onu ulogu koju je dobila kod nekih drugih naroda.\nAko nije, ima je sad, a sad je i najvažnije.','https://www.laguna.rs/_img/korice/4772/o_dukatu_sa_likom_starca-selimir_radulovic_v.jpg',4,31),(33,'Senka osmog eona',2018,1090,30,0,'„Reč je o retkoj zbirci – o duhovnom i pesničkom traganju i nalaženju.“ Vladika Irinej\n\n„U najoskudnije vreme koje se više ne pita čemu pesnici, nego proglašava i kraj poezije, svedoci smo snažne obnove duhovnog pesništva na srpskom jeziku. U toj obnovi sve je uočljivije i značajnije pesmotvorje Selimira Radulovića.“ Akademik Matija Bećković\n\n„U srpskoj književnosti duhovna poezija uvek je postojala iako nije bila uvek jednako zastupljena. Zato se u naše vreme može govoriti ne toliko o obnavljanju napuštenog, koliko o jačanju jedne linije kontinuiteta koja nikada nije prekidana, a koja je u knjizi Selimira Radulovića Senka osmog eona dobila svoje novo i upečatljivo pesničko ovaploćenje.“ Akademik Predrag Piper','https://www.laguna.rs/_img/korice/3867/senka_osmog_eona-selimir_radulovic_v.jpg',4,31),(34,'Besnilo',2011,1390,57,0,'Virus u obliku metka pogađa u srce civilizacije... Niko nije bezbedan.\nVizija kraja sveta koja odgovara onome što smo od sveta napravili.\nBiološka katastrofa, u razmerama nepoznatim savremenoj istoriji, pogađa londonski aerodrom Hitrou u jeku letnje sezone. Usled mutacije virusa besnila u jednoj naučnoj laboratoriji, epidemija se širi zastrašujućom brzinom jer nijedna vakcina ne deluje. U karantinu, koji obuhvata ogroman kompleks, zateklo se na desetine hiljada putnika i nameštenika aerodroma...\nU ovoj univerzalnoj metafori, čije književne srodnike možemo prepoznati u Kamijevoj Kugi ili Saramagovom Slepilu, zaraženi ljudi vode rat ne samo sa zlokobnim psećim virusom, nego i sa besnilom u sebi i besnilom svoje okoline, razotkrivajući tako zastrašujuću istinu o ljudskoj prirodi: nije nam potreban virus da bi ludilo koje s rođenjem nosimo iskazalo sve svoje vidove i probilo tanku opnu obzira i samopoštovanja.','https://www.laguna.rs/_img/korice/1711/besnilo-borislav_pekic_v.jpg',4,23),(35,'Poslednja žrtva',2017,1390,60,0,'U cik zore jednog snežnog februarskog dana u srcu Kineske četvrti u Londonu pronađena je hladnjača sa telima dvanaest smrznutih devojaka, po svemu sudeći ilegalnih imigrantkinja, umrlih od hipotermije.\nU kabini napuštene hladnjače smrti detektiv Maks Vulf iz stanice Centralni Vest End pronalazi trinaest pasoša.\nPotraga za trinaestom devojkom vodi Maksa Vulfa u mračno srce sveta krijumčarenja ljudi, masovnih migracija i tržišta robova 21. veka i primorava ga da postavi pitanje koje opseda naše doba: šta biste sve učinili da steknete dom?','https://www.laguna.rs/_img/korice/3473/poslednja_zrtva-toni_parsons_v.jpg',1,26),(36,'Teodorin prsten',2017,1250,60,0,'Pripremajući se za modnu reviju na kojoj će manekenke nositi i srednjovekovni srpski nakit, novinar Novak Ivanović odlazi u manastir Banjsku i obilazi ruševine rudarskog grada Novo Brdo... Tamo nazire deo strašne tajne i stare legende o prstenu vizantijske princeze i potom srpske kraljice Teodore, majke cara Dušana Silnog: umreće brzo svako ko ga stavi na ruku!\nJoš 1915. godine, razbivši u kosovskom manastiru Banjskoj sarkofag kraljice Teodore, prsten je uzeo, tačnije – ukrao, regent Aleksandar Karađorđević i odneo ga u Beograd. Sto godina kasnije prsten se pojavio na ruci lepe manekenke na reviji upriličenoj u čast modnog magnata iz Milana. Pozajmljen za tu priliku iz Narodnog muzeja u Beogradu, prsten je istovremeno i opsesija tajnog društva iz Italije zakletog u nameri da obnovi istočno rimsko carstvo, pa agent tajnog društva takođe dolazi na reviju kojoj prisustvuje beogradski džet-set, ambasadori, policajci, obaveštajci, političari, tajkuni, mafijaši, novinari...\nZa nepun sat, u toku modne revije u uglednom beogradskom hotelu, dogodiće se tri ubistva, a svi ubijeni, kako će se pokazati, bili su u neposrednom dodiru s kobnim prstenom.','https://www.laguna.rs/_img/korice/4344/teodorin_prsten-vanja_bulic_v.jpg',1,25),(37,'Ubistvo u Orijent ekspresu',2016,1190,30,0,'Agata Kristi je najobjavljivanija autorka svih vremena. Jedino Biblija i Šekspirov opus premašuju ukupni tiraž njenih dela – prodato ih je milijardu na engleskom jeziku i još milijardu u prevodu na stotinu drugih jezika.\nNešto posle ponoći snežni smetovi zaustavili su Orijent ekspres. Ovaj raskošni voz iznenađujuće je pun za to doba godine, ali jutro dočekuje s jednim putnikom manje. Američki magnat leži mrtav u svom kupeu, proboden dvanaest puta, a vrata su zaključana iznutra. Ubica je zarobljen u vozu s ostalim putnicima i detektiv Herkul Poaro mora da ga otkrije pre nego što se desi novo ubistvo.','https://www.laguna.rs/_img/korice/3608/ubistvo_u_orijent_ekspresu-agata_kristi_v.jpg',1,24),(38,'Una',2020,1190,30,0,'Roman Una, koji je nastao 1981. godine, spada u red najčitanijih dela Mome Kapora, ne samo zbog intrigantne ljubavne priče oko koje se radnja odvija već i zbog načina na koji je autor uspeo da dočara duh jednog vremena i tako ga zauvek sačuvao od zaborava. Napuštajući svoju „komfornu zonu“ i upuštajući se u vezu sa studentkinjom, profesor Babić dovodi u pitanje sopstvenu egzistenciju, ali zauzvrat dobija mnogo više ili mu se, možda, samo tako čini. Ova knjiga, koja se čita u jednom dahu, vratiće nas nekoliko decenija unazad, ali će nas isto tako podsetiti na neke od situacija s kojima se i danas suočavamo.','https://www.laguna.rs/_img/korice/5097/una_v.jpg',1,27);
/*!40000 ALTER TABLE `knjiga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `komentar`
--

DROP TABLE IF EXISTS `komentar`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `komentar` (
  `idKomentar` int NOT NULL AUTO_INCREMENT,
  `Korisnik_idKorisnik` int NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  `tekst` varchar(100) NOT NULL,
  PRIMARY KEY (`idKomentar`),
  KEY `fk_Korisnik_has_Knjiga_Knjiga4_idx` (`Knjiga_idKnjiga`),
  KEY `fk_Korisnik_has_Knjiga_Korisnik4_idx` (`Korisnik_idKorisnik`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Knjiga4` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Korisnik4` FOREIGN KEY (`Korisnik_idKorisnik`) REFERENCES `korisnik` (`idKorisnik`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `komentar`
--

LOCK TABLES `komentar` WRITE;
/*!40000 ALTER TABLE `komentar` DISABLE KEYS */;
INSERT INTO `komentar` VALUES (1,1,1,'Odlicna knjiga.');
/*!40000 ALTER TABLE `komentar` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `korisnik`
--

DROP TABLE IF EXISTS `korisnik`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `korisnik` (
  `idKorisnik` int NOT NULL AUTO_INCREMENT,
  `korisnicko_ime` varchar(30) NOT NULL,
  `sifra` varchar(150) NOT NULL,
  `ime` varchar(45) NOT NULL,
  `prezime` varchar(45) NOT NULL,
  `brojGodina` int NOT NULL,
  `adresa` varchar(50) NOT NULL,
  `Uloga_idUloga` int NOT NULL,
  PRIMARY KEY (`idKorisnik`),
  KEY `fk_Korisnik_Uloga_idx` (`Uloga_idUloga`),
  CONSTRAINT `fk_Korisnik_Uloga` FOREIGN KEY (`Uloga_idUloga`) REFERENCES `uloga` (`idUloga`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `korisnik`
--

LOCK TABLES `korisnik` WRITE;
/*!40000 ALTER TABLE `korisnik` DISABLE KEYS */;
INSERT INTO `korisnik` VALUES (1,'ivanna','$2a$10$YcCGBm/kLnMQueToaoc7quXscJsgx5sDkOyFYmwXw17EDCAzxCDz6','Ivana','Milutinovic',21,'Banjska 12',1),(2,'milica11','$2a$10$RjOMhgjXDw2CR27JU1EtSu9b/tk.JK80XRwcXAlGTgk1589kf4nde','Milica','Milovanovic',23,'Dositeja Obradovica 5',1),(3,'jovan23','$10$YcCGBm/kLnMQueToaoc7quXscJsgx5sDkOyFYmwXw17EDCAzxCDz6','Jovan','Milic',32,'Dunavska 13',2),(4,'jovan22','$2a$10$yb/8VSidt1MEi3SV4RiqVO51DXQPFkgd2H.T.wGw0Zxst337LhZdy','Jovan','Milic',32,'Dunavska 3',2);
/*!40000 ALTER TABLE `korisnik` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `narudzbenica`
--

DROP TABLE IF EXISTS `narudzbenica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `narudzbenica` (
  `idNarudzbenica` int NOT NULL AUTO_INCREMENT,
  `Korisnik_idKorisnik` int NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  `datumNarucivanja` date NOT NULL,
  `ukupanIznos` int NOT NULL,
  PRIMARY KEY (`idNarudzbenica`),
  KEY `fk_Korisnik_has_Knjiga_Knjiga2_idx` (`Knjiga_idKnjiga`),
  KEY `fk_Korisnik_has_Knjiga_Korisnik2_idx` (`Korisnik_idKorisnik`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Knjiga2` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Korisnik2` FOREIGN KEY (`Korisnik_idKorisnik`) REFERENCES `korisnik` (`idKorisnik`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `narudzbenica`
--

LOCK TABLES `narudzbenica` WRITE;
/*!40000 ALTER TABLE `narudzbenica` DISABLE KEYS */;
INSERT INTO `narudzbenica` VALUES (5,1,1,'2021-06-16',880),(6,2,20,'2021-06-16',1150),(7,2,20,'2021-06-16',1150),(8,2,20,'2021-06-16',1150),(9,2,20,'2021-06-16',1150),(10,2,20,'2021-06-16',1150),(11,2,29,'2021-06-16',1090),(12,2,29,'2021-06-16',1090),(17,1,27,'2021-06-17',1400),(18,1,27,'2021-06-17',1400),(19,1,34,'2021-06-17',1590),(20,1,34,'2021-06-17',1590),(21,1,34,'2021-06-17',1590),(22,1,2,'2021-06-17',1150),(23,1,2,'2021-06-17',1150),(24,1,2,'2021-06-17',1150);
/*!40000 ALTER TABLE `narudzbenica` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `ocena`
--

DROP TABLE IF EXISTS `ocena`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ocena` (
  `idOcena` int NOT NULL AUTO_INCREMENT,
  `Korisnik_idKorisnik` int NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  `vrednost` int NOT NULL,
  PRIMARY KEY (`idOcena`),
  KEY `fk_Korisnik_has_Knjiga_Knjiga3_idx` (`Knjiga_idKnjiga`),
  KEY `fk_Korisnik_has_Knjiga_Korisnik3_idx` (`Korisnik_idKorisnik`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Knjiga3` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Korisnik3` FOREIGN KEY (`Korisnik_idKorisnik`) REFERENCES `korisnik` (`idKorisnik`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ocena`
--

LOCK TABLES `ocena` WRITE;
/*!40000 ALTER TABLE `ocena` DISABLE KEYS */;
INSERT INTO `ocena` VALUES (1,1,1,4),(2,2,3,4),(3,2,29,5),(4,2,26,5),(5,1,11,5),(6,4,38,5);
/*!40000 ALTER TABLE `ocena` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `omiljenaknjiga`
--

DROP TABLE IF EXISTS `omiljenaknjiga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `omiljenaknjiga` (
  `Korisnik_idKorisnik` int NOT NULL,
  `Knjiga_idKnjiga` int NOT NULL,
  PRIMARY KEY (`Korisnik_idKorisnik`,`Knjiga_idKnjiga`),
  KEY `fk_Korisnik_has_Knjiga_Knjiga1_idx` (`Knjiga_idKnjiga`),
  KEY `fk_Korisnik_has_Knjiga_Korisnik1_idx` (`Korisnik_idKorisnik`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Knjiga1` FOREIGN KEY (`Knjiga_idKnjiga`) REFERENCES `knjiga` (`idKnjiga`),
  CONSTRAINT `fk_Korisnik_has_Knjiga_Korisnik1` FOREIGN KEY (`Korisnik_idKorisnik`) REFERENCES `korisnik` (`idKorisnik`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `omiljenaknjiga`
--

LOCK TABLES `omiljenaknjiga` WRITE;
/*!40000 ALTER TABLE `omiljenaknjiga` DISABLE KEYS */;
INSERT INTO `omiljenaknjiga` VALUES (1,1),(1,11),(1,19),(1,31),(1,37);
/*!40000 ALTER TABLE `omiljenaknjiga` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pisac`
--

DROP TABLE IF EXISTS `pisac`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pisac` (
  `idPisac` int NOT NULL AUTO_INCREMENT,
  `ime` varchar(45) NOT NULL,
  `prezime` varchar(45) NOT NULL,
  PRIMARY KEY (`idPisac`)
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pisac`
--

LOCK TABLES `pisac` WRITE;
/*!40000 ALTER TABLE `pisac` DISABLE KEYS */;
INSERT INTO `pisac` VALUES (1,'Zoran','Milekić'),(2,'Rej','Konoli'),(3,'Luka','Mičeta'),(4,'Mark','Blejk'),(6,'Džordž','R.R. Martin'),(7,'Džastin','Kronin'),(8,'Den','Simons'),(9,'Pavle','Zelić'),(10,'Adam','Nevil'),(11,'Iskender','Pala'),(12,'Aleksandar','Puškin'),(14,'Mihail','Bulgakov'),(15,'Ivo','Andrić'),(16,'Sofi','Kinsela'),(17,'Fredrik','Bakman'),(18,'Dženet','Maklaud Troter'),(19,'Nikolas','Sparks'),(20,'Jelena','Bačić Alimpić'),(23,'Borislav','Pekić'),(24,'Agata','Kristi'),(25,'Vanja','Bulić'),(26,'Toni','Parsons'),(27,'Momo','Kapor'),(28,'Fjodor','Mihailovič Dostojevski'),(29,'Ketrin','Kukson'),(30,'Miroslav','Antić'),(31,'Selimir','Radulović');
/*!40000 ALTER TABLE `pisac` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `uloga`
--

DROP TABLE IF EXISTS `uloga`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `uloga` (
  `idUloga` int NOT NULL AUTO_INCREMENT,
  `naziv` varchar(45) NOT NULL,
  `plata` int DEFAULT NULL,
  PRIMARY KEY (`idUloga`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `uloga`
--

LOCK TABLES `uloga` WRITE;
/*!40000 ALTER TABLE `uloga` DISABLE KEYS */;
INSERT INTO `uloga` VALUES (1,'korisnik',0),(2,'radnik',45000);
/*!40000 ALTER TABLE `uloga` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-09-18 12:19:10
