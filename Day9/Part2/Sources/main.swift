// The Swift Programming Language
// https://docs.swift.org/swift-book


import Foundation

let now = Date()
let input = """
3177129244151474618511889049952590361440506324865194981911908290283699486581737527686622143057229873812440851138793547485552427095688469804274596436674568741431682049757787607211751252412015236226626792719955561735899565638045646497725320812653141619208387354698821017439443948113946699749760476089711785833954864070187980152678656314615339395897365871551149343471244850699661304519282385893046336933789815581732906340271759769521205173369172802370785116874335733378324747636020985652834463318157404865348074554293735245296387894057959027567762157530627237929198457744341284199149428457953843591293338947456353803324425647489581394984279377247383727641298992482441778153569869686914203815581219826560846797175336461453783646283837239890464742905442251963584380794045283841252216946319924033123375417769893786408615826298191756526515577010359565435112402584806351713939592063427952284617732778434631212816896046284770159431806145292445887432246516272113634193153544868318111053581237863278671535558373474186849848301394841490679020456411478692667868999247601949992847443851404519501912291892167486869224486427887322234338453625162186936921592249918213772041568928325227801657253738183044599026335653996263605170644445177363113657882824859615761865783886126121868568175899498192827497838499906831365742989811645394295827552899814310862814434258497214398720216775267383879136557775754138246657374276828857187044313215455332202110124960604848818837177297956393394116218426998682803978376275447684156819158090693657535523448927616569191179996421861070577224372355247114985768967218437382281732776236494778727112819120348632892690262051927325905075299755585214107643601228777536811365715325392050801033114878913011444034945098865228953522359525438280377329892980894487138820898946354937695285565654501842868333161287598523494293283961171121178589897959528561748680495175456179302663319884219318866897822294479314631141907642285638102994644368444183262041193247561548434969865184717630267972788266907258568710594472662350839961476221199395433062521985449218673669971051993737488249533368192540336656238271727345528799886421724314266250367338252285574934209018372525931255273132629421557689697130816798592647105458117429689723859281161060667379288229422661214124355151467115423861508979418088467045495992398457751863206053564610983927917432601423705334737747172283948781638755224566804315139517147367956572605966973829321646518290493643253988267159452958121989847916687749773262485681427675709840448970523831638751668143888574118465481270671030264250626258477625604718888077539276829257765025144554148572862851499457463071671174856174599259102840992131309919384177134660907916967779504918231413889230816798894444386170838479736532461521449427695357773746829787764970255083339150564854883947913813108116554493744687718631587744936646674829121492209883313288293668223963987844125018606833158039428595601288862858585652331532756316961851381144601080472287358497704731203216682752822130654432895388814269883477266524804057297932474389381568907723603731198758774031639713263254155574509138953571725361755923892549854189128846905192635021711715995519214827281678732725164417901391215464611220793758202825415978686431312091341388619444979339628694387394118625206184199225902469869098742398558523959683826142945935651964663496187589893491787188334242415946954316242929808916793719976599301744552020157890779989698044412430234187895444985282787313937027619986894664174847144528554868499254809181736898913497248157412610307959222012444976424599259684196483679244288039298546578621374062585655205610837181492177777063229161731241565912268041549247115953889916835810988711155032838537597994633029683315534917779487431741621029168898186920106487473163375914705158441651891566615159493831362591161364941292554622512435831954963529563333899484735673287316914917223531269661577216651042531452704438582125704157984520933829746618977197222692907824211561688214952934211117177344909870738043264471123730247568691988613961996733753499746134874891582268884953976568765047356991826565696341248481841210944769276337383361338017133269156917314558776971974489195669746095142998865244759330218155871297621318773650646380181162161474333366552577673447977632947124302945527434649254163839884682317993432891691165871812726279672841323222406355482781259878715073108687384065739316658611704180136081711538814415514855787426992079253139762568839111422185486472953844701771611180176320333683324641814777551950878957297332672148256966123773485562388095178426593015196310774021977949837789853483396748748227992991653737729498559190608984682879126243638332494457238698427238382383392659729261739338614674249730272978519786312922979132986855576680224165546782522766468450465839501361632372986943173877837922418998766255698965511865739728764092692744762426881072816096385960612189709634344418698541378070867072947953773817942382429516901096456734315163537871818962968837103253149298186094631843626820788413603011492254116973923027465952822938804265222792335060107278902827252083758769384517289864114524315335695914769424979113608349308446594522802939511578486792802043731723662247354127403282491218615023902010499430546727371676562770132624797680263070999933248414234099633594901639931122283291605539634368288349497324114072545172272418661254721071478455774767429479229821781592395979604072868070979420441958998191363081688168778965543814183448381383856682437517883631633398191043302810707120648637779656971766406092794090667779278381551074715320808658148122307879742729256824153842658438919239175114686961717310243867246699454241366589516725221760878110374477358776565155609723656194216961531516966358119823629853832674749392281121614368526883226488555620224993666389734426762457685381832059891368489319718785537099196462941539756888586592106813582065678093787646869311236240414256614994473974572564938866997746236842588458292662865032874031645199531383589854496961688483925633498126788239509226574315169676701863985784207130721670823413284971227721718988813189362962281122112280332588228027646834568535704824588094977880353194506474316315682654812327735170107829193945519487352440395722763537651968624537117968892574851460992114248971326462262667672051535142432788823045239851393491401615899847492496636964551315802598984322219786186131868746167838559036622768524026923147628023687193935556735186191435557081804974705399735058792148849877367723186647694716771594382121441298519188625553541183649434906250193644179487725193671798783587795061175695557386861039981818132950842824419573961810247790275350522380866947798983305169764066687183919721123564748783323644938126991263913254178246303651797170547091645297815280225286306018631376691772496651464314233952249250128681483145365944302562966877644848674151681595747562453240625787455895481391483584416844765354366369368910157372142115861126728924719796536081396093707676758611355328915744439277777011453967705488855160924391376814139020104879699525134541242525935588648474557650315669479643766733824151668940941116799677396567391670139182667868477726382333166051825038598938196867155752623635495016752759762497481196932852276421423842993861309927397673303391165189147249202418209067144310617541176914275433622865868181976884658262275830284284319491632262196476801546138795866537713198824318907399188975957450166723356578592957208643696272203417557777373483935480737957993314829223864820893855942849915367361222449412402228511776982595197381222227857676535890937912496488736452254989783312296489425455466258611722312221133032753461365174152282187666371383434373488262768426873249696243395755736430808350498450316091572641814934473071996967249288632091397845261878975017677920279850992343864448398212754284921217358060954760678059794519302630324212333756925549857685371893976981216911811757537722542823475598917848956551404434845838699494139640636531692778824878737043747587889585239652186745111486912728268762454137856545809566506893187734356546231255956527963345928754806540787711863486163731301927226822178730453028491430451515887958811878794140655511147755219991584959604047908698943163658823547625472512809996177898961493855144607066236215263386494029683781427293932962637993315327508178171851886192975266395797295330656463336143239622215388565047413357272227895924108715731488209057548948669925863952921664507215497694994073324579503943307161643089488225202853815047968976744457144091637453927216698967598745357498211078748640869112988215653840786911793952889656986853172017788233335928775329532928545534488261746731298419153751569470487784673059457136435013394319156451553047797536218824704510903620865964325159239454436543768475929489467573612967798917469128969251123156605226914849993374796058243167123057859763713245502038403536303468656092478822306537481451451330639689345397879463774751102516892689537345849236655526236983126854639373134732635922237678295461851169943853506274911311626930354299696078925785242016328265542818917594415456346812551772311992244331358167876711813111333720437354748228714496165471381297961042484756736452123010625940635374902176118277734017676371924982165649942230402631781420584833858653629826741422738058942536802595373933953594979145959730332630586069555516655274787349401687549564379322216214444393113622237466888943631531574730814379299525135696895798153660229535131323265171732844624226711535396762413381872391189214318916334278917837672927759011616027843333989372997888811595431968104735486165157787399168737128714481361114892161381169522534829148399337223617324373574723625955254119869284336730616250108341309813457714494836504145546189437123546995847367925971987710421187361718524019917636437799769131753129802221709918781891143571757430388037696643306821415857498670473315447390619951262036344861111625194889254678409385645577316657838264489885863836238312693870218678958467748627502041255693853991809442658671161066692282673197668091313662429456991951422467335254319626871247852632272511883760673162713982924193151975849924273458972910142424639061914529865721666710256232549519236653843327759791747252786446735513848071141661759142929540733538116642656566571949695471226352351476605558501341313451262399395287733679108538339933285638405454663335585845695333921315729164811536283377496643424781215871967159806698234124648396359163289617486650687246551246946284606498244054412258965069142560812029425523143417944210883956193369896510169520129222124370605069166963433591738488321162901158366476203925599589324085315030522099496597515945893622191425461287352658902996966663217836245688794230243097115730672822311687767655928182692179246985415914647068716399315671937644552631345746274355759317805525485258429135453878499126899699129932133239269219488443547370548726682652601151323747239154531679425163605287605971151248337127864146158591517195448741473414275075934647298725695250704518487855172020904941359764177252933995287679812456356144887323877632817147333939568775137565713539189776923879296865237484342011459214904943485366419367185048696986626346598919831735666382169456476256582253741592441744776429145064252280891122483811291932638186482442667553794597305867876565621796598469923961724398935184978951846267772315858255849037298729884878524883377063519514128346155784949975523977869217899656866086111862647231654558916377146833376882862541752997192113742916221055376783584121209526964431368556281398982449675460339271896033323153149824616799508020202387233533391114114890878356968527143364365135505743658869325044717312252718792056356397531785854193609614925512623278789064174522932593856757333518271077639612741687404280471687521552693759112160133387461987267164842221909981733413985758933754985928198766481026671954673737347430146371214511873712579313391598818625363367745836266224884539162099422143213690108696765072744968261441512798745574342641893358303245624683657437158884585234793054409267985557215790705526748547697928999427488790731213662346701664201333297186586546316583728173829868111261111227624142522979414296425277254448811581676417932966262797195491807559138012761043933417906599407463442789161278155089511139274644771752919538685867986442919536501195779767478738582296271578635672148531655793611353289866249264431447752260423297311688274570741464495146122761419056989577196145715161689255104151458982754393419249114961679074865582881442463615997176332273779641754827306539679517659532701349743682394072931284779917777386411795242626901671195991847457882598414260545859444456509699745179335950755553242197277532752358586694897090625831896765519235812735181548431187503686188458977199833828478874574388192836291694947526485386764755354434731098374618224184937492927189746256227538995871953844571252532753317458701236571598792875964424307577429936769216529415201633451010335537743283869038784238544159247329536396932653533692421597981427308242974747992443767586994098951377927971125820783997444332297960457472556190523211771238355212901277749098206667655615408068994740403580895234546445747235259159428488465864602919549975183337773668724232299938128615931451769668499932841579759396216555917658303477538599686031355914513767193217104317226481782410348938498026397750812528168096524623384124867884536691106099912171729917566165287911715814922197595292305511323474132584826077175282447045876814236455505335348818605025274128505223176965811887897957505275631975609715789724195831924079954332858254587052578290209647756121704524768966526647993917776376698999235616108159849546341133166831818041224819994543498280228375217054924711955936374135882924991964164270654751263264545583815054744055253485982093115597118142998086783066655127475221963227319084632087984577314419666518263539609679869584804357151491688565322580407120435065393925174092838810598556565983661771839269834145876728687824431327468793574930264483988899303530349714383776615984159482964137961159691815248931767627924078447193708182585038726318861726862026912978222721841837666766124825419396403285818455261014889681892174497921171537614241568640353094609833974223991818629916851458975723467148424265343693614367749323852890316490522855961448386815349461264460997666769778511976785279873452588090171030925554742615799569217821568628787199917166241132622563312635245017626727362616546799953537804067394465783594604175646164755599425979794485866944146660516516488787425055153358217377434342976029789555818871542966526573732660621238841020661846462938802010102817398130785268425345637844653667178332956995348531848993767186736344588030607784727797852366214715942421902531811218351195144251331113378388358855465078243435544474601592667226368749103923861591572990476163341391171725171672386710928278765442796889114938393235427360303271364656262237731848453536191794938322195825125730787938707919755574989426314290698577947878656344248037174967974413138623255336826561266463139076418945102532155264139847343214751389801875702891872565169954125074381540116015161122899425761839295675707585864912959072319171878962971026707073502488401723786332913344985537983548431852277550768321972879251324773753259833275571852416205727472474898939356017257575789780972415683288417996846087407953461568512869519499256962485278151847136024818988351877422284323591739287815628623991333051743868539498515516758842848769561626882794669418143311256924326051257933168572451349929117291397312920314811146351407021236931272655443573249745933341136615882060466275829824377232209597867311209595117343912783222059124662157633601810808158836754464137379293197720482789468415281172972187846117641264447865987261741037235241698758659663813612931269829545184169964840546787664794865377652193115363995388259570868964772435684141822222162329755331553776194919972070569047385843214310753269969736385558725580562457702357344917673670893040562368637824361722407359983741771222656326379078293753355496512376396561613173672819386165757577601297382018313185558962981318207012828498883512458676534662903098129135616729585444847989623177694852912842817351558244384727315760524528978528386941985088692179428345574541746254747651534152326747853441291283855676475995598897858953562638377110911427725670311192839610528724648774786814908158812578814085739939112298387217464937186654224810312812756395376018997873236724875846613762221592867590533121507775848768845161445510327291486955613371533163245191669555674330295028921976301380963984675989903336452838851812766967317379416328656749711870328592269274484122201982695810902829813488767470834559668531425539828448216782494553237343541768684242928565277661612165345841847066831568346994569153164962973217302159876549467463683051329744974585726644224944969861489721324232738567979917324248491646679537213373671222937872569379508891968728608876898932997139416832297549609151153215406615244224912714757644262260574433667284357280487349864987775460857961861035833965776774604342449116937413796657175436531724865235317662296991177748799368275819297465246266955485401633516492854942102567393976868895412637172897188458764652858420702084178531281451387683801529499282687088446043668444115019833364689726337754219151149584126440904742339183811994324716941370725062436731628914288669563024519680119296924740569814485675507089465820948916672368791611677028728280418729346690618130738681365116748542357575259629578267781783405775159297622334307355159962762283476816398637876830374376828683764916659551709977494469649811924028918988635776215423679582294610589671898113711036889537661035235081179365123615355982212671723387468842663232448738511126168633239292647643853188914628575754105967434329789750288577875279923869121949226326687251494233122026385178339637199693679351541628816870773985972842502042706157365912533073356536233847718899976597226466457248318685109797853982572271639470818017881057807064362817435735572028901230246531915723305193332368322990617664811429832847796673391975396534383845904963271722118712776173917318976118788336691090998885897182257398875321508557129549278061903311361271887311414772704656131215604831901028839656328950847746671449559032712617807099307656679853357467417369349638259660346664739392373782217582462649372834651558373782909248634520126661516175622013581040129243611284821576924861698947299245915746571294343051808197387725186043367176115564368975693890438976959940759581943752595764334891851216814757315126835226948857726293711712187169808848688778732529276832252520745795903216898678313877435496734459891586861037875076506968861117322079773934497223145251621291646353514317484141244461465885117638542554407654225368485110962997889146163277202595615066391739324637225646983187149132952084699632557633327627575025669569797736359750568673455038278250314020718019677413901945237461803532522264512278702942647488503776498190347438477499172778331092188838501232922041228782242933699164721829976848721525473375864515831512409691735817536187653685418372774437359314956453449054517660186518937369844750341636739418848948884640777590409980186336622398774778796558475190447738433534375246274489955071272261264951505475129098326538103824267258513025859498339445106976562433419419781752147720693966577191343333351046995035567582892492936882711351297821648845826935589426101269576775637512881545472855106553793817949858157561957813396380927739489286996494122715109921169612223751178135905646904015985963296588471466746492742433562422665660623761752487573752899714873064491753896271724434283224228093726245328484483641527345552285237916958222631660966438131817589492725926569145563141393131762057429181366689493085393538731469726255516495511483147211806867171873972414592550172466182898589337504160545013528968996071591860206652473892204358239829679827167150567526648485854392152665443723652130366361291390918778291997585720257356482863321032678395916577572082824858989521426946527631305056598889412884764746387953222836361722429532413586386558576635543477186656336121382823687275126771429479173244655598984299158674303139206263602858881251335730745631212827746947115629197697682351663220546259346460405320551062903381234297996273894595704412463873597
"""
let solution =
performPart2(input: input)
print(solution)
print(Date().timeIntervalSince(now))
 


public func performPart2(
    input: String
) -> Int {
    let bitcode =
    input.enumerated().reduce([Block]()) { acc, next in
        let (index, position) = next
        guard let length = Int("\(position)") else {
            assertionFailure("Invalid position \(position).")
            return acc
        }
        if index % 2 == 0 {
            return acc + Array(repeating: Block.file(id: index / 2), count: length)
        } else {
            return acc + Array(repeating: Block.free, count: length)
        }
    }
    print(bitcode)
    let fragmentsCount = bitcode.filter(\.isFile).count
    print(fragmentsCount)
    let groups: [[Block]] =
    bitcode
        .reduce([[Block]]()) { acc, block in
            if acc.isEmpty {
                return [[block]]
            } else if let last = acc.last, last.map(\.fileID).contains(block.fileID) {
                // append to block
                return acc.prefix(acc.count - 1) + [last + [block]]
            } else if acc.last?.map(\.fileID).contains(block.fileID) == false {
                // append to list
                return acc + [[block]]
            } else {
                assertionFailure()
                return acc
            }
        }
    print(groups)
    let reversedGroups = groups.reversed().map { $0 }
    let defrag: [[Block]] =
    defrag2(
        acc: groups,
        reversedStore: reversedGroups
    )
    let flatDefrag =
    defrag
        .flatMap { $0 }
    let description =
    defrag
        .flatMap { xs in
            xs.map(\.description).joined()
        }
        .joined()
    let solution =
    flatDefrag
        .enumerated()
        .reduce(0) { acc, next in
            let (offset, element) = next
            return acc + offset * element.checksum
        }
    return solution
}

enum Block {
    case file(id: Int)
    case free
}
extension Block: CustomStringConvertible {
    var description: String {
        switch self {
        case .file(id: let id):
            return "\(id)"
        case .free:
            return "."
        }
    }
    
    var isFile: Bool {
        switch self {
        case .file:
            return true
        case .free:
            return false
        }
    }
    
    var fileID: Int {
        if case .file(id: let id) = self {
            id
        } else {
            -1
        }
    }
    
    var checksum: Int {
        if case .file(id: let id) = self {
            id
        } else {
            0
        }
    }
}
extension Block: Equatable {}
extension Array {
    func removing(at index: Int) -> Self {
        var new = self
        new.remove(at: index)
        return new
    }
}

func defrag2(
    acc: [[Block]],
    reversedStore: [[Block]]
) -> [[Block]] {
    // nextToDefrag: block index in reversedStore
    // indexToDefrag: block index in acc
    // defragBlock: block
    // nextAvailableSpace: free space index in acc
    guard let nextToDefrag =
            reversedStore.firstIndex(where: \.isFile),
          let indexToDefrag =
            acc.firstIndex(of: reversedStore[nextToDefrag]) else {
        return acc
    }
    let defragBlock = acc[indexToDefrag]
    if let nextAvailableSpace = acc[..<indexToDefrag].firstIndex(where: { $0.isFree(defragBlock.count) }),
       nextAvailableSpace < indexToDefrag {
        var newAcc = acc
        newAcc.remove(at: indexToDefrag)
        newAcc.insert(Array(repeating: Block.free, count: defragBlock.count), at: indexToDefrag)
        newAcc.remove(at: nextAvailableSpace)
        newAcc.insert(Array(repeating: Block.free, count: acc[nextAvailableSpace].count - defragBlock.count), at: nextAvailableSpace)
        newAcc.insert(defragBlock, at: nextAvailableSpace)
        return defrag2(
            acc: newAcc,
            reversedStore: reversedStore.removing(at: nextToDefrag)
        )
    } else { // nop
        return defrag2(
            acc: acc,
            reversedStore: reversedStore.removing(at: nextToDefrag)
        )
    }
}

extension Array where Element == Block {
    var isFile: Bool {
        map(\.isFile).allSatisfy({ $0 })
    }
    func isFree(_ count: Int) -> Bool {
        self.count >= count
        &&
        map(\.isFile).allSatisfy({ !$0 })
    }
}
