!classDefinition: #PortfolioTest category: #'PortfolioTreePrinter-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTest methodsFor: 'tests' stamp: 'np 5/15/2018 16:41:19'!
messageSelectorAndArgumentNames
	"comment stating purpose of message"

	| temporary variable names |! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	account := ReceptiveAccount new.

	self assert: 0 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:45'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:34'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 = account balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:22:46'!
test03_01WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	self assert: (Withdraw register: withdrawValue on: account) value equals: withdrawValue 
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:48'!
test04PortfolioBalanceIsSumOfManagedAccountsBalance

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	 	
	Deposit register: 100 on: account1.
	Deposit register: 200 on: account2.
		
	self assert:300 = complexPortfolio balance .
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 18:53'!
test05PortfolioCanManagePortfolios

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	Deposit register: 100 on:account1.
	Deposit register: 200 on: account2.
	Deposit register: 300 on: account3.

	self assert: 600 = composedPortfolio balance .! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:36'!
test06ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account registers: deposit).
	self assert: (account registers: withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/25/2017 20:14:30'!
test07ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account registers: deposit).
	self deny: (account registers:withdraw).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:51'!
test08PortfolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:25'!
test08PortofolioKnowsTransactionsRegisteredByItsManagedAccounts 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
 	self assert: (composedPortfolio registers: deposit1).
	self assert: (composedPortfolio registers: deposit2).
	self assert: (composedPortfolio registers: deposit3).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:00'!
test10ReceptiveAccountManageItSelf 

	| account1 |
	account1 := ReceptiveAccount new.
		
	self assert: (account1 manages:account1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:01'!
test11ReceptiveAccountDoNotManageOtherAccount

	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
	self deny: (account1 manages: account2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:02'!
test12PortfolioManagesComposedAccounts

	| account1 account2 account3 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self assert: (complexPortfolio manages: account1).
	self assert: (complexPortfolio manages: account2).
	self deny: (complexPortfolio manages: account3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:03'!
test13PortfolioManagesComposedAccountsAndPortfolios 

	| account1 account2 account3 complexPortfolio composedPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	self assert: (composedPortfolio manages: account1).
	self assert: (composedPortfolio manages: account2).
	self assert: (composedPortfolio manages: account3).
	self assert: (composedPortfolio manages: complexPortfolio).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/26/2011 16:28'!
test14AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on:account1.
		
	self assert: 1=account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/18/2011 17:15'!
test15PortfolioTransactionsIsTheUnionOftsAccountsTransactions 

	| account1 account2 account3 complexPortfolio account composedPortfolio deposit1 deposit2 deposit3 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 200 on: account2.
	deposit3 := Deposit register: 300 on: account3.
		
	self assert: 3 = composedPortfolio transactions size .
	self assert: (composedPortfolio transactions includes: deposit1).
	self assert: (composedPortfolio transactions includes: deposit2).
	self assert: (composedPortfolio transactions includes: deposit3).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test16PortfolioKnowsItsAccountsTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1= (composedPortfolio transactionsOf:account1) size .
	self assert: ((composedPortfolio transactionsOf: account1) includes:deposit1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:23'!
test17PortfolioKnowsItsPortfoliosTransactions 

	| account1 account2 account3 complexPortfolio composedPortfolio deposit1 deposit2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.
		
	deposit1 := Deposit register: 100 on: account1.
	deposit2 := Deposit register: 100 on: account2.
	Deposit register: 100 on: account3.
		
	self assert: 2 = (composedPortfolio transactionsOf:complexPortfolio) size .
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit1).
	self assert: ((composedPortfolio transactionsOf:complexPortfolio) includes:deposit2).
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 9/12/2011 13:24'!
test18PortfolioCanNotAnswerTransactionsOfNotManagedAccounts 

	| account1 account2 account3 complexPortfolio |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.
		
	self 
		should: [ complexPortfolio transactionsOf:account3 ] 
		raise: Error 
		withExceptionDo: [ :accountNotManaged |
			self assert: Portfolio accountNotManagedMessageDescription = accountNotManaged messageText ]
! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:24:31'!
test19CanNotCreatePortfoliosWithRepeatedAccount 

	| account1 |

	account1 := ReceptiveAccount new.
	self 
		should: [ Portfolio with: account1 with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage  = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/13/2011 19:15'!
test20CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolio 

	| account1 account2 complexPortfolio |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	complexPortfolio := Portfolio with: account1 with: account2.

	self 
		should: [ Portfolio with: complexPortfolio with: account1 ]
		raise: Error
		withExceptionDo: [ :invalidPortfolio |
			self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/8/2018 16:11:42'!
test20_01CanNotCreatePortfoliosWithAccountsManagedByOtherManagedPortfolioTwo

    | account1 account2 account3 complexPortfolio1 complexPortfolio2 |
    
    account1 := ReceptiveAccount new.
    account2 := ReceptiveAccount new.
    account3 := ReceptiveAccount new.    
    complexPortfolio1 := Portfolio with: account1 with: account2.
    complexPortfolio2 := Portfolio with: account3 with: account1.

    self 
        should: [ Portfolio with: complexPortfolio1 with: complexPortfolio2 ]
        raise: Error
        withExceptionDo: [ :invalidPortfolio |
            self assert: Portfolio accountAlreadyManagedErrorMessage = invalidPortfolio messageText ] ! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 05:27'!
test21TransferShouldWithdrawFromFromAccountAndDepositIntoToAccount

	| fromAccount toAccount |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert: -100 = fromAccount balance.
	self assert:  100 = toAccount balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:30:52'!
test21_01TransferIsReachedFromTransacctions

	| fromAccount toAccount transfer |

	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new.

	transfer := Transfer register: 100 from: fromAccount to: toAccount.
		
	self assert:  100 = transfer value.
	self assert: fromAccount transactions first transfer equals: transfer.
	self assert: toAccount transactions first transfer equals: transfer.
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 9/28/2017 15:27:01'!
test22AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| fromAccount toAccount fromAccountLines toAccountLines|

	fromAccount := ReceptiveAccount new.
	toAccount := ReceptiveAccount new.
	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	
	fromAccountLines := self accountSummaryLinesOf: fromAccount.
	toAccountLines := self accountSummaryLinesOf: toAccount.
	
	self assert: 3 = fromAccountLines size.
	self assert: 'Deposito por 100' = (fromAccountLines at: 1).
	self assert: 'Extraccion por 50' = (fromAccountLines at: 2).
	self assert: 'Transferencia por -100' = (fromAccountLines at: 3).
	
	self assert: 1 = toAccountLines size.
	self assert: 'Transferencia por 100' = (toAccountLines at: 1).
	! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test23ShouldBeAbleToBeQueryTransferNet

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test24CertificateOfDepositShouldWithdrawInvestmentValue

	| account toAccount |
	account := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 1000 on: account.
	Withdraw register: 50 on: account.
	Transfer register: 100 from: account to: toAccount.
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
		
	self assert: 100 =(self investmentNetOf:account).
	self assert: 750 = account balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test25ShouldBeAbleToQueryInvestmentEarnings

	| account investmentEarnings |
	account := ReceptiveAccount new. 
		
	CertificateOfDeposit register: 100 during: 30 at: 1/10 on: account.
	CertificateOfDeposit register: 100 during: 60 at: 15/100 on: account.

	investmentEarnings := 
		(100*((1/10)/360)*30) +
		(100*((15/100)/360)*60).
		
	self assert: investmentEarnings = (self investmentEarningsOf: account).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 8/13/2017 18:37:21'!
test26AccountSummaryShouldWorkWithCertificateOfDeposit

	| fromAccount toAccount lines |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	lines := self accountSummaryLinesOf: fromAccount.
		
	self assert: 4 = lines size.
	self assert: 'Deposito por 100' =  (lines at: 1).
	self assert: 'Extraccion por 50' =  (lines at: 2).
	self assert: 'Transferencia por -100' = (lines at: 3).
	self assert: 'Plazo fijo por 1000 durante 30 dias a una tna de 10%' = (lines at: 4).! !

!PortfolioTest methodsFor: 'tests' stamp: 'HernanWilkinson 7/14/2011 06:58'!
test27ShouldBeAbleToBeQueryTransferNetWithCertificateOfDeposit

	| fromAccount toAccount |
	fromAccount := ReceptiveAccount new. 
	toAccount := ReceptiveAccount new. 

	Deposit register: 100 on: fromAccount.
	Withdraw register: 50 on: fromAccount.
	Transfer register: 100 from: fromAccount to: toAccount.
	Transfer register: 250 from: toAccount to: fromAccount.
	CertificateOfDeposit register: 1000 during: 30 at: 1/10 on: fromAccount.
		
	self assert: 150 = (self accountTransferNetOf: fromAccount).
	self assert: -150 = (self accountTransferNetOf: toAccount).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 5/14/2018 21:11:21'!
test28PortfolioTreePrinterPrintsTheCompositeInDepthFirstOrder

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
	
	lines := self portofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: 'composedPortfolio' = (lines at: 1).
	self assert: ' complexPortfolio' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: '  account2' = (lines at: 4).
	self assert: ' account3' = (lines at: 5).! !

!PortfolioTest methodsFor: 'tests' stamp: 'DR 5/14/2018 19:49:58'!
test29ReversePortfolioTreePrinterPrintsTheCompositeStartingFromTheLeaves

	| account1 account2 account3 complexPortfolio composedPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	complexPortfolio := Portfolio with: account1 with: account2.
	composedPortfolio := Portfolio with: complexPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: composedPortfolio put: 'composedPortfolio'.
	accountNames at: complexPortfolio put: 'complexPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self reversePortofolioTreeOf: composedPortfolio namingAccountWith: accountNames.
		
	self assert: 5 = lines size.
	self assert: ' account3' = (lines at: 1).
	self assert: '  account2' = (lines at: 2).
	self assert: '  account1' = (lines at: 3).
	self assert: ' complexPortfolio' = (lines at: 4).
	self assert: 'composedPortfolio' = (lines at: 5).
	! !


!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 19:12:36'!
accountSummaryLinesOf: aReceptiveAccount 
	
	^(AccountSummaryLines of: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 18:49:42'!
accountTransferNetOf: aReceptiveAccount 
	
	^(AccountTransferNet of: aReceptiveAccount ) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 19:23:45'!
investmentEarningsOf: aReceptiveAccount

	^ (AccountInvestmentEarnings of: aReceptiveAccount) value.! !

!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 19:21:55'!
investmentNetOf: aReceptiveAccount 
	
	^(AccountInvestmentNetOf of: aReceptiveAccount ) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 21:05:54'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^(PortfolioTree of: aPortfolio with: aDictionary) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'DR 5/14/2018 21:11:59'!
reversePortofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^((self portofolioTreeOf: aPortfolio namingAccountWith: aDictionary) reverse)! !


!classDefinition: #AccountTransaction category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransaction methodsFor: 'evaluating' stamp: 'HernanWilkinson 7/14/2011 06:48'!
value

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #CertificateOfDeposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #CertificateOfDeposit
	instanceVariableNames: 'value tna numberOfDays account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:40:40'!
affectBalance: balance
	^balance - value! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:25:20'!
answerQuery: aQuery

	^aQuery queryCertificateOfDeposit: self! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 21:36:51'!
initializeWith: anAmmountOfMoney during: aNumberOfDays at: aTna

	value := anAmmountOfMoney.
	numberOfDays := aNumberOfDays.
	tna := aTna.! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:11:02'!
numberOfDays
	
	^numberOfDays! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:10:53'!
tna
	
	^tna! !

!CertificateOfDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 18:45:50'!
value
	
	^value! !


!CertificateOfDeposit methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:52:28'!
affect: anObject with: aQuery

	^aQuery affect: anObject asCertificateOfDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CertificateOfDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
CertificateOfDeposit class
	instanceVariableNames: ''!

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 21:33:45'!
register: anAmmountOfMoney during: numberOfDays at: tna on: account

	| certificateOfDeposit |
	
	certificateOfDeposit := self with: anAmmountOfMoney during: numberOfDays at: tna.
	account register: certificateOfDeposit.
		
	^ certificateOfDeposit ! !

!CertificateOfDeposit class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 21:35:30'!
with: anAmmountOfMoney during: numberOfDays at: tna

	^self new initializeWith: anAmmountOfMoney during: numberOfDays at: tna.! !


!classDefinition: #Deposit category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'DR 5/14/2018 18:41:04'!
affect: anObject with: aQuery

	^aQuery affect: anObject asDeposit: self.! !

!Deposit methodsFor: 'initialization' stamp: 'DR 5/14/2018 19:40:53'!
affectBalance: balance
	
	^balance + value! !

!Deposit methodsFor: 'initialization' stamp: 'np 5/16/2018 21:12:05'!
answerQuery: aQuery

	^aQuery queryDeposit: self! !

!Deposit methodsFor: 'initialization' stamp: 'np 5/15/2018 16:22:20'!
executeSummarizingAccountQuery: aPortfolioQuery

	^aPortfolioQuery executeForDeposit: self! !

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'PortfolioTreePrinter-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 19:41'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Withdraw category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:51:48'!
affect: anObject with: aQuery

	^aQuery affect: anObject asWithdraw: self.! !

!Withdraw methodsFor: 'oldDD' stamp: 'np 5/15/2018 16:43:12'!
executeSummarizingAccountQuery: aPortfolioQuery

	^aPortfolioQuery executeForWithdraw: self! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/14/2011 05:54'!
value

	^ value ! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:42:07'!
affectBalance: balance

	^balance - value! !

!Withdraw methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:12:20'!
answerQuery: aQuery

	^aQuery queryWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/14/2011 05:32'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #SummarizingAccount category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
manages: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:34'!
registers: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:34'!
balance

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:35'!
transactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:26'!
anyManagedAccountManages: anAccount 

	^accounts anySatisfy: [ :managedAccount | (managedAccount manages: anAccount) or: [ anAccount manages: managedAccount ] ] ! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/8/2018 16:46:01'!
manages: anAccount

	^ self = anAccount  or: [ self anyManagedAccountManages: anAccount ]! !

!Portfolio methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 19:20'!
registers: aTransaction

	^ accounts anySatisfy: [ :anAccount | anAccount registers: aTransaction ]  ! !


!Portfolio methodsFor: 'initialization' stamp: 'np 5/16/2018 21:27:09'!
answerQuery: aQuery

	^aQuery queryPortfolio: self! !

!Portfolio methodsFor: 'initialization' stamp: 'DR 5/10/2018 00:49:38'!
initializeWith: anAccount with: anotherAccount

	managedAccounts := OrderedCollection new.
	managedAccounts add: anAccount.
	managedAccounts add: anotherAccount.! !

!Portfolio methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 19:19'!
initializeWithAll: aCollectionOfAccounts

	accounts := aCollectionOfAccounts   ! !


!Portfolio methodsFor: 'oldDD' stamp: 'DR 5/14/2018 20:47:09'!
executeSummarizingAccountQuery: aPortfolioQuery

	^aPortfolioQuery executeForPortfolio: self! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 8/13/2017 17:47:44'!
balance

	^ accounts sum: [ :account | account balance ]
! !

!Portfolio methodsFor: 'transactions' stamp: 'DR 5/14/2018 20:18:59'!
managedAccounts

	^accounts ! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 9/25/2017 19:40:20'!
transactions 

	^ accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]
	! !

!Portfolio methodsFor: 'transactions' stamp: 'np 5/16/2018 21:50:17'!
transactionsDo: aMonoArgumentedClosure

	| allTransactions |

	allTransactions _ (accounts 
		inject: OrderedCollection new 
		into: [ :transactions :account | transactions addAll: account transactions. transactions ]).
		
	allTransactions do: aMonoArgumentedClosure
	! !

!Portfolio methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 19:27'!
transactionsOf: anAccount 

	^ (self manages: anAccount)
		ifTrue: [ anAccount transactions ] 
		ifFalse: [ self error: self class accountNotManagedMessageDescription]
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'PortfolioTreePrinter-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:33:13'!
with: leftAccount with: rightAccount

	^ self withAll: (Array with: leftAccount with: rightAccount)! !

!Portfolio class methodsFor: 'instance creation' stamp: 'HAW 5/8/2018 16:40:55'!
withAll: aCollectionOfAccounts

	self checkCreationPreconditions: aCollectionOfAccounts.
	
	^self new initializeWithAll: aCollectionOfAccounts ! !


!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:28'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Portfolio class methodsFor: 'error messages' stamp: 'HernanWilkinson 7/13/2011 19:27'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts

	^ aCollectionOfAccounts do: [ :targetAccount | 
			(sourceAccount = targetAccount) not ifTrue: [ 
				(sourceAccount manages: targetAccount) ifTrue: [ self error: self accountAlreadyManagedErrorMessage ] ] ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkAccountsAreUnique: aCollectionOfAccounts

	aCollectionOfAccounts asSet size = aCollectionOfAccounts size
		ifFalse: [ self error: self accountAlreadyManagedErrorMessage ]! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:21'!
checkCreationPreconditions: aCollectionOfAccounts

	self checkAccountsAreUnique: aCollectionOfAccounts.
	self checkNoCircularReferencesIn: aCollectionOfAccounts! !

!Portfolio class methodsFor: 'assertions' stamp: 'HernanWilkinson 9/18/2011 17:22'!
checkNoCircularReferencesIn: aCollectionOfAccounts

	aCollectionOfAccounts do: [ :sourceAccount | self check: sourceAccount doesNotManagaAnyOf: aCollectionOfAccounts ]! !


!classDefinition: #ReceptiveAccount category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'np 5/16/2018 21:26:56'!
answerQuery: aQuery

	^aQuery queryReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'DR 5/10/2018 20:44:20'!
balance

	^ transactions
		inject: 0
		into: [ :balance :transaction | transaction affectBalance: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'DR 5/10/2018 21:38:22'!
investmentNet

	^ transactions
		inject: 0
		into: [ :balance :transaction | transaction affectInvestmentNet: balance ]! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'np 5/16/2018 21:46:45'!
transactionsDo: aMonoArgumentedClosure

	^ transactions do: aMonoArgumentedClosure! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'DR 5/10/2018 21:55:46'!
transferNet

	^ transactions
		inject: 0
		into: [ :balance :transaction | transaction affectTransferNet: balance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'DR 5/14/2018 20:46:36'!
executeSummarizingAccountQuery: aSummarizingAccountQuery

	^aSummarizingAccountQuery executeForReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
manages: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HernanWilkinson 7/13/2011 18:37'!
registers: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 21:20:10'!
accountSummaryLines
	^ transactions
		inject: OrderedCollection new 
		into: [ :summary :transaction | summary add: transaction asString. summary. ]! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 21:47:08'!
investmentEarnings
	^ transactions
		inject: 0
		into: [ :balance :transaction | transaction affectInvestmentEarnings: balance ]! !


!classDefinition: #SummarizingAccountQuery category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #SummarizingAccountQuery
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!


!classDefinition: #AccountInvestmentEarnings category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountQuery subclass: #AccountInvestmentEarnings
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentEarnings methodsFor: 'initialization' stamp: 'DR 5/14/2018 19:26:07'!
initializeWith: anAccount

	account _ anAccount! !


!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:18:14'!
queryCertificateOfDeposit: aCertificateOfDeposit

	^(aCertificateOfDeposit value*(aCertificateOfDeposit tna/360)*(aCertificateOfDeposit numberOfDays))! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:17:22'!
queryDeposit: aDeposit

	^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:17:41'!
queryTransferDeposit: aTransferDeposit

	^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:17:51'!
queryTransferWithdraw: aTransferWithdraw

	^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:18:00'!
queryWithdraw: aWithDraw

	^0! !

!AccountInvestmentEarnings methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:54:25'!
value

	| investmentEarnings |
	
	investmentEarnings  _ 0.
	account transactionsDo: [ :transaction | investmentEarnings _ investmentEarnings + (transaction answerQuery: self)].
	
	^investmentEarnings
			! !


!AccountInvestmentEarnings methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:26:55'!
affect: investmentEarnings asCertificateOfDeposit: aCertificateOfDeposit

	^investmentEarnings + (aCertificateOfDeposit value*(aCertificateOfDeposit tna/360)*(aCertificateOfDeposit numberOfDays))! !

!AccountInvestmentEarnings methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:27:08'!
affect: investmentEarnings asDeposit: aDeposit

	^investmentEarnings! !

!AccountInvestmentEarnings methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:27:14'!
affect: investmentEarnings asTransferDeposit: aTransferDeposit

	^investmentEarnings! !

!AccountInvestmentEarnings methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:27:18'!
affect: investmentEarnings asTransferWithdraw: aTransferWithdraw

	^investmentEarnings! !

!AccountInvestmentEarnings methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:27:23'!
affect: investmentEarnings asWithdraw: aWithDraw

	^investmentEarnings! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentEarnings class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentEarnings class
	instanceVariableNames: ''!

!AccountInvestmentEarnings class methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:26:07'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountInvestmentNetOf category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountQuery subclass: #AccountInvestmentNetOf
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountInvestmentNetOf methodsFor: 'initialization' stamp: 'DR 5/14/2018 19:13:44'!
initializeWith: anAccount

	account _ anAccount! !


!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:16:19'!
queryCertificateOfDeposit: aCertificateOfDeposit

	^aCertificateOfDeposit value! !

!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:13:57'!
queryDeposit: aDeposit

	^0! !

!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:15:59'!
queryTransferDeposit: aTransferWithdraw

	^0! !

!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:15:46'!
queryTransferWithdraw: aTransferWithdraw

	^0! !

!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:14:56'!
queryWithdraw: aWithdraw

	^0! !

!AccountInvestmentNetOf methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:54:59'!
value

	| investmentNet |
	
	investmentNet  _ 0.
	account transactionsDo: [ :transaction | investmentNet _ investmentNet + (transaction answerQuery: self)].
	
	^investmentNet
			! !


!AccountInvestmentNetOf methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:20:42'!
affect: investmentNet asCertificateOfDeposit: aCertificateOfDeposit

	^investmentNet + aCertificateOfDeposit value! !

!AccountInvestmentNetOf methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:20:52'!
affect: investmentNet asDeposit: aDeposit

	^investmentNet! !

!AccountInvestmentNetOf methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:20:58'!
affect: investmentNet asTransferDeposit: aTransferDeposit

	^investmentNet! !

!AccountInvestmentNetOf methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:21:05'!
affect: investmentNet asTransferWithdraw: aTransferWithdraw

	^investmentNet! !

!AccountInvestmentNetOf methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:21:13'!
affect: investmentNet asWithdraw: aWithDraw

	^investmentNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountInvestmentNetOf class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountInvestmentNetOf class
	instanceVariableNames: ''!

!AccountInvestmentNetOf class methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:13:44'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountSummaryLines category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountQuery subclass: #AccountSummaryLines
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountSummaryLines methodsFor: 'initialization' stamp: 'DR 5/14/2018 18:57:34'!
initializeWith: anAccount

	account _ anAccount! !


!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:18:40'!
queryCertificateOfDeposit: aCertificateOfDeposit

	^('Plazo fijo por ', aCertificateOfDeposit value asString, ' durante ', aCertificateOfDeposit numberOfDays asString, ' dias a una tna de ', (aCertificateOfDeposit tna * 100) asString, '%').
! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:19:09'!
queryDeposit: aDeposit

	^('Deposito por ', (aDeposit value asString)).
! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:19:20'!
queryTransferDeposit: aTransferDeposit

	^('Transferencia por ', (aTransferDeposit value asString)).
! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:19:29'!
queryTransferWithdraw: aTransferWithdraw

	^ ('Transferencia por -', (aTransferWithdraw value asString)).
! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:19:45'!
queryWithdraw: aWithdraw

	^('Extraccion por ', (aWithdraw value asString)).
! !

!AccountSummaryLines methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:55:59'!
value

	| summaryLines |
	
	summaryLines  _ OrderedCollection new.
	account transactionsDo: [ :transaction | summaryLines add: (transaction answerQuery: self)].
	
	^summaryLines
			! !


!AccountSummaryLines methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:10:40'!
affect: summaryLines asCertificateOfDeposit: aCertificateOfDeposit

	summaryLines add: ('Plazo fijo por ', aCertificateOfDeposit value asString, ' durante ', aCertificateOfDeposit numberOfDays asString, ' dias a una tna de ', (aCertificateOfDeposit tna * 100) asString, '%').
	^summaryLines! !

!AccountSummaryLines methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:09:48'!
affect: summaryLines asDeposit: aDeposit

	summaryLines add: ('Deposito por ', (aDeposit value asString)).
	^summaryLines! !

!AccountSummaryLines methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:08:52'!
affect: summaryLines asTransferDeposit: aTransferDeposit

	summaryLines add: ('Transferencia por ', (aTransferDeposit value asString)).
	^summaryLines! !

!AccountSummaryLines methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:06:03'!
affect: summaryLines asTransferWithdraw: aTransferWithdraw

	summaryLines add: ('Transferencia por -', (aTransferWithdraw value asString)).
	^summaryLines! !

!AccountSummaryLines methodsFor: 'oldDD' stamp: 'DR 5/14/2018 19:04:51'!
affect: summaryLines asWithdraw: aWithdraw

	summaryLines add: ('Extraccion por ', (aWithdraw value asString)).
	^summaryLines! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummaryLines class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountSummaryLines class
	instanceVariableNames: ''!

!AccountSummaryLines class methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 18:57:34'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #AccountTransferNet category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountQuery subclass: #AccountTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!AccountTransferNet methodsFor: 'initialization' stamp: 'DR 5/14/2018 18:49:18'!
initializeWith: anAccount

	account _ anAccount! !


!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:20:03'!
queryCertificateOfDeposit: aCertificateOfDeposit

	^0! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:20:09'!
queryDeposit: aDeposit

	^0! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:20:18'!
queryTransferDeposit: aTransferDeposit

	^aTransferDeposit value! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:20:36'!
queryTransferWithdraw: aTransferWithdraw

	^-1 * aTransferWithdraw value! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:20:46'!
queryWithdraw: aWithDraw

	^0! !

!AccountTransferNet methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:57:05'!
value
		
	| transferNet |
	
	transferNet  _ 0.
	account transactionsDo: [ :transaction |transferNet _ (transferNet + (transaction answerQuery: self))].
	
	^transferNet
			! !


!AccountTransferNet methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:50:38'!
affect: transferNet asCertificateOfDeposit: aCertificateOfDeposit

	^transferNet! !

!AccountTransferNet methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:50:33'!
affect: transferNet asDeposit: aDeposit

	^transferNet! !

!AccountTransferNet methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:50:29'!
affect: transferNet asTransferDeposit: aTransferDeposit

	^transferNet + aTransferDeposit value! !

!AccountTransferNet methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:50:24'!
affect: transferNet asTransferWithdraw: aTransferWithdraw

	^transferNet - aTransferWithdraw value! !

!AccountTransferNet methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:50:19'!
affect: transferNet asWithdraw: aWithDraw

	^transferNet! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: #'PortfolioTreePrinter-Ejercicio'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 18:48:55'!
of: anAccount

	^self new initializeWith: anAccount! !


!classDefinition: #PortfolioTree category: #'PortfolioTreePrinter-Ejercicio'!
SummarizingAccountQuery subclass: #PortfolioTree
	instanceVariableNames: 'accountsNamesDictionary'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!PortfolioTree methodsFor: 'initialization' stamp: 'DR 5/14/2018 20:13:04'!
initializeFor: anAccount with: aDictionary

	account _ anAccount.
	accountsNamesDictionary _ aDictionary .! !

!PortfolioTree methodsFor: 'initialization' stamp: 'DR 5/14/2018 19:54:03'!
initializeWith: anAccount

	account _ anAccount! !


!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:27:47'!
queryPortfolio: aPortfolio

	^(aPortfolio managedAccounts
		inject: OrderedCollection new
		into: [ :lines :managedAccount |
			lines, ((PortfolioTree of: managedAccount with: accountsNamesDictionary) value)
	])
	collect: [ :aString | ' ', aString]
	
	
	

! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:27:53'!
queryReceptiveAccount: aReceptiveAccount

	^OrderedCollection new! !

!PortfolioTree methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:11:18'!
value

	| firstLine |
	
	firstLine _ OrderedCollection new.
	firstLine add: (accountsNamesDictionary at: account).

	^firstLine, (account answerQuery: self)! !


!PortfolioTree methodsFor: 'oldDD' stamp: 'DR 5/14/2018 21:04:46'!
executeForPortfolio: aPortfolio

	^(aPortfolio managedAccounts
		inject: OrderedCollection new
		into: [ :lines :managedAccount |
			lines, ((PortfolioTree of: managedAccount with: accountsNamesDictionary) value)
	])
	collect: [ :aString | ' ', aString]
	
	
	

! !

!PortfolioTree methodsFor: 'oldDD' stamp: 'DR 5/14/2018 21:10:48'!
executeForReceptiveAccount: aReceptiveAccount

	^OrderedCollection new! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTree class' category: #'PortfolioTreePrinter-Ejercicio'!
PortfolioTree class
	instanceVariableNames: ''!

!PortfolioTree class methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 20:13:40'!
of: anAccount with: aDictionary

	^self new initializeFor: anAccount with: aDictionary ! !


!classDefinition: #Transfer category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 19:42:12'!
initializeFor: aValue

	value := aValue ! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:43:32'!
value
	^value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'PortfolioTreePrinter-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 19:43:19'!
for: anAmmountOfMoney

	^ self new initializeFor: anAmmountOfMoney! !

!Transfer class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:49:55'!
register: anAmmountOfMoney from: aSourceAccount to: aDestinationAccount
	| transfer transferDeposit transferWithdraw |
	
	transfer := self for: anAmmountOfMoney.
	
	transferDeposit := TransferDeposit for: transfer.
	transferWithdraw := TransferWithdraw for: transfer.
	
	aSourceAccount register: transferWithdraw.
	aDestinationAccount register: transferDeposit.
	
	^transfer ! !


!classDefinition: #TransferDeposit category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TransferDeposit
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferDeposit methodsFor: 'initialization' stamp: 'DR 5/10/2018 20:39:21'!
initializeWith: aTransfer
	transfer := aTransfer! !


!TransferDeposit methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:52:13'!
affect: anObject with: aQuery

	^aQuery affect: anObject asTransferDeposit: self.! !

!TransferDeposit methodsFor: 'oldDD' stamp: 'np 5/15/2018 16:23:10'!
executeSummarizingAccountQuery: aPortfolioQuery

	^aPortfolioQuery executeForTransferDeposit: self! !


!TransferDeposit methodsFor: 'value' stamp: 'DR 5/14/2018 18:54:18'!
value

	^transfer value! !


!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:41:39'!
affectBalance: balance
	^balance + self value! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:12:41'!
answerQuery: aQuery

	^aQuery queryTransferDeposit: self! !

!TransferDeposit methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:46:22'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferDeposit class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferDeposit class
	instanceVariableNames: ''!

!TransferDeposit class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:40:14'!
for: aTransfer
	^self new initializeWith: aTransfer! !


!classDefinition: #TransferWithdraw category: #'PortfolioTreePrinter-Ejercicio'!
Object subclass: #TransferWithdraw
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'PortfolioTreePrinter-Ejercicio'!

!TransferWithdraw methodsFor: 'initialization' stamp: 'DR 5/10/2018 20:39:30'!
initializeWith: aTransfer
	transfer := aTransfer! !


!TransferWithdraw methodsFor: 'oldDD' stamp: 'DR 5/14/2018 18:52:02'!
affect: anObject with: aQuery

	^aQuery affect: anObject asTransferWithdraw: self.! !

!TransferWithdraw methodsFor: 'oldDD' stamp: 'np 5/15/2018 16:23:28'!
executeSummarizingAccountQuery: aPortfolioQuery

	^aPortfolioQuery executeForTransferWithdraw: self! !


!TransferWithdraw methodsFor: 'value' stamp: 'DR 5/14/2018 18:54:25'!
value

	^transfer value! !


!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DR 5/14/2018 19:41:57'!
affectBalance: balance

	^balance - self value! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'np 5/16/2018 21:12:58'!
answerQuery: aQuery

	^aQuery queryTransferWithdraw: self! !

!TransferWithdraw methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:46:28'!
transfer

	^transfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferWithdraw class' category: #'PortfolioTreePrinter-Ejercicio'!
TransferWithdraw class
	instanceVariableNames: ''!

!TransferWithdraw class methodsFor: 'as yet unclassified' stamp: 'DR 5/10/2018 20:40:33'!
for: aTransfer
	^self new initializeWith: aTransfer! !
