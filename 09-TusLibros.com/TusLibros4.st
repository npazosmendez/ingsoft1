!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'np 6/18/2018 01:24:34'!
setUp
	testObjectsFactory _ TusLibrosTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'np 6/18/2018 01:24:34'!
setUp
	testObjectsFactory _ TusLibrosTestObjectsFactory new.
	debitBehavior _ [ :anAmount :aCreditCard |
	nil ].! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemTest
	instanceVariableNames: 'testObjectsFactory nowBehaviour tusLibrosSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:26:34'!
test01CanCreateCartOnSuccesfulAuthentication

	self shouldntFail: [ self createEmptyCartForRegisteredUser ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 02:33:58'!
test02UnregisteredUserCanNotCreateCart

	self assertAuthenticationFailedInTusLibrosSystemDoing: [
		tusLibrosSystem
			createCartFor: testObjectsFactory aUserNotRegisteredOnTusLibros
			with: testObjectsFactory dummyPassword ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:41:40'!
test02bRegisteredUserWithIncorrentPasswordCanNotCreateCart

	self assertAuthenticationFailedInTusLibrosSystemDoing: [
		tusLibrosSystem
			createCartFor: testObjectsFactory aUserRegisteredOnTusLibros
			with: 'Wrong password' ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:41:47'!
test03CanNotListUnexistantCart
	| cartId |
	
	cartId _ 0.
	
	self assertFailureForUnexistingCartInTusLibrosSystemDoing: [ tusLibrosSystem listCart: cartId ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 02:09:42'!
test03bCanNotAddBooksToUnexistantCart
	| cartId |
	
	cartId _ 846455.
	
	self assertFailureForUnexistingCartInTusLibrosSystemDoing: [
		self addToTusLibros: 3 ofItemSoldByStoreTo: cartId
		].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:41:52'!
test04BookListOfNewCartIsEmpty
	| cartId |
	
	cartId _ self createEmptyCartForRegisteredUser .
	
	self assert: (tusLibrosSystem listCart: cartId) isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:41:56'!
test05BooksAddedToTheCartAreListed
	| cartId aQuantity |
	
	cartId _ self createEmptyCartForRegisteredUser .
	aQuantity _ 5.
	self addToTusLibros: aQuantity ofItemSoldByStoreTo: cartId.
	
	self assertListOf: cartId isTheItemSoldByStoreRepeated: aQuantity.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:04:42'!
test07AUserCanCreateMoreThanOneEmptyCart
	| aCartID anotherCartID |
	
	aCartID _ self createEmptyCartForRegisteredUser.
	anotherCartID _ self createEmptyCartForRegisteredUser .
	
	self deny: aCartID = anotherCartID.
	self assert: (tusLibrosSystem listCart: aCartID) isEmpty.
	self assert: (tusLibrosSystem listCart: anotherCartID) isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 02:59:38'!
test08BooksAddedToMultipleCartsByAUserGetListedInTheirRespectiveCarts
	| aCartID anotherCartID |
	
	aCartID _ self createEmptyCartForRegisteredUser .
	anotherCartID _ self createEmptyCartForRegisteredUser .
	self addToTusLibros: 7 ofItemSoldByStoreTo: aCartID.
	self addToTusLibros: 5 ofItemSoldByStoreTo: anotherCartID.
	
	self assertListOf: aCartID isTheItemSoldByStoreRepeated: 7.
	self assertListOf: anotherCartID isTheItemSoldByStoreRepeated: 5.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:54:05'!
test09BooksAddedByMultipleUsersGetListedInTheirRespectiveCarts
	| aCartID anotherCartID |

	aCartID _ self createEmptyCartForUserA.
	anotherCartID _ self createEmptyCartForUserB.
	self addToTusLibros: 3 ofItemSoldByStoreTo: aCartID.
	self addToTusLibros: 98 ofItemSoldByStoreTo: anotherCartID.
	
	self assertListOf: aCartID isTheItemSoldByStoreRepeated: 3.
	self assertListOf: anotherCartID isTheItemSoldByStoreRepeated: 98.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:28:33'!
test10CanNotCheckOutUnexistantCart
	| cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	cartId _ 0.
	
	self assertFailureForUnexistingCartInTusLibrosSystemDoing: [
			tusLibrosSystem
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				on: testObjectsFactory today 
		].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:38:16'!
test11CanNotCheckOutEmptyCart
	| cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ testObjectsFactory dummyCreditCardNumber .
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	cartId _ self createEmptyCartForRegisteredUser .
	
	self
		should: [
			tusLibrosSystem
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'Darío Reyes'
				on: testObjectsFactory today ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier cartCanNotBeEmptyErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:27:58'!
test12CanCheckOutNonEmptyCart
	| cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ testObjectsFactory dummyCreditCardNumber .
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	cartId _ self createCartWithItems .
	
	self shouldntFail: [
			tusLibrosSystem
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				on: testObjectsFactory today 
			].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:18:26'!
test13CanCheckOutCartWithUnexpiredCreditCardInThePast
	| cartId creditCardNumber expirationMonth |
	
	creditCardNumber _ testObjectsFactory dummyCreditCardNumber .
	expirationMonth _ testObjectsFactory aMonthInThe1800s.
	cartId _ self createCartWithItems .
	
	self shouldntFail: [
			tusLibrosSystem
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: expirationMonth
				ownedBy: 'José Luis Miguel'
				on: (DateAndTime year: 1800 day: 0) 
			].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:45:43'!
test13bCartStopsExistingWhenCheckedOut
	
	| cartID |
	
	cartID _ self createCartWithItems.
	self successfulCheckoutOf: cartID.
	
	self assertFailureForUnexistingCartInTusLibrosSystemDoing: [
			tusLibrosSystem listCart: cartID.
		].
	
! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:20:16'!
test14PurchasesOfAUserOnANewSystemAreEmpty
			
	self assert: self purchasesOfUserA isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:53:39'!
test15BooksOfASingleCheckoutCartAreListedInPurchases
	| cartId purchases |
	
	cartId _ self createAndCheckOutCartForUserAWithItemSoldQuantity: 2.

	purchases _ self purchasesOfUserA.
	
	self assert: purchases isTheItemSoldByStoreRepeated: 2.
! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:53:10'!
test16BooksOfMultipleCheckoutCartsAreListedInPurchases
	| purchases |
	
	self createAndCheckOutCartForUserAWithItemSoldQuantity: 6.
	self createAndCheckOutCartForUserAWithItemSoldQuantity: 5.

	purchases _ self purchasesOfUserA.
	
	self assert: purchases isTheItemSoldByStoreRepeated: 11.
! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:51:52'!
test17BooksBoughtByDifferentUsersGetListedInTheirRespectiveLists
	| firstCartId secondCartId firstPurchases secondPurchases |
	
	firstCartId _ self createAndCheckOutCartForUserAWithItemSoldQuantity: 1.
	secondCartId _ self createAndCheckOutCartForUserBWithItemSoldQuantity: 2.
	
	firstPurchases _ self purchasesOfUserA.
	secondPurchases _ tusLibrosSystem
		listPurchasesOf: testObjectsFactory userBRegisteredOnTusLibros
		with: testObjectsFactory thePasswordOfUserB .
		
	self assert: firstPurchases isTheItemSoldByStoreRepeated: 1.
	self assert: secondPurchases isTheItemSoldByStoreRepeated: 2.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:42:36'!
test18ExpiredCartCanNotBeListed
	| cartId |
	
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self assertFailureForExpiredCartInTusLibrosSystemDoing: [  tusLibrosSystem listCart: cartId ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:55:15'!
test19ExpiredCartCanNotBeAddedTo
	| cartId |
	
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self assertFailureForExpiredCartInTusLibrosSystemDoing: [
		self addToTusLibros: 2 ofItemSoldByStoreTo: cartId 
		].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:25:09'!
test20ExpiredCartCanNotBeCheckout
	| cartId |
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	self addToTusLibros: 2 ofItemSoldByStoreTo: cartId.
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self assertFailureForExpiredCartInTusLibrosSystemDoing: [
			tusLibrosSystem
				checkOut: cartId
				chargingOn: testObjectsFactory dummyCreditCardNumber
				expiringOn: testObjectsFactory aMonthOfTheFuture
				ownedBy: testObjectsFactory dummyName
				on: testObjectsFactory today 
			].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:42:46'!
test21ListingCartExtendsItsExpirationDeadline
	| cartId |
	
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 15) ].
	tusLibrosSystem listCart: cartId.
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self shouldntFail: [ tusLibrosSystem listCart: cartId ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 03:42:50'!
test22AddingToCartExtendsItsExpirationDeadline
	| cartId |
	
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 15) ].
	self addToTusLibros: 2 ofItemSoldByStoreTo: cartId.
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self shouldntFail: [ tusLibrosSystem listCart: cartId ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:50:43'!
test23CheckingOutCartExtendsItsExpirationDeadline
	| cartId |
	
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	cartId _ self createEmptyCartForRegisteredUser .
	self addToTusLibros: 2 ofItemSoldByStoreTo: cartId.
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 15) ].
	self successfulCheckoutOf: cartId.
	nowBehaviour _ [ testObjectsFactory december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self shouldntFail: [ tusLibrosSystem listCart: cartId ]
! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:47:05'!
test80PurchasedAmmountOfAUserOnANewSystemIsZero
	| purchasedAmmount |
		
	purchasedAmmount _ self purchasedAmmountOfUserB.
	
	self assert: purchasedAmmount equals: 0.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:56:03'!
test81CheckoutCartAddsToPurchasedAmmount
	| purchasedAmmount |
	
	self createAndCheckOutCartForUserBWithItemSoldQuantity: 2.
	purchasedAmmount _ self purchasedAmmountOfUserB.
	
	self assert: purchasedAmmount equals: testObjectsFactory itemSellByTheStorePrice * 2.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:49:50'!
test82DifferentUsersShowTheirRespectivePurchasedAmmounts
	| firstCartId firstPurchasedAmmount secondCartId secondPurchasedAmmount |
	
	firstCartId _ self createAndCheckOutCartForUserAWithItemSoldQuantity: 12.
	secondCartId _ self createAndCheckOutCartForUserBWithItemSoldQuantity: 54.

	firstPurchasedAmmount _ self purchasedAmmountOfUserA.
	secondPurchasedAmmount _ self purchasedAmmountOfUserB.

	self assert: firstPurchasedAmmount equals: testObjectsFactory itemSellByTheStorePrice *12.
	self assert: secondPurchasedAmmount equals: testObjectsFactory itemSellByTheStorePrice *54.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/18/2018 15:14:40'!
test90CheckoutsGenerateDifferentTransactionIDs
	
	| firstTransactionID firstCartID secondCartID secondTransactionID |
	
	firstCartID _ self createCartWithItems.
	secondCartID _ self createCartWithItems.
	firstTransactionID _ self successfulCheckoutOf: firstCartID.
	secondTransactionID _ self successfulCheckoutOf: secondCartID.
	
	self deny: firstTransactionID = secondTransactionID.
	
! !


!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 02:33:30'!
addToTusLibros: aQuantity ofItemSoldByStoreTo: aCartID
	tusLibrosSystem
		add: aQuantity
		of: testObjectsFactory itemSellByTheStore
		to: aCartID.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 15:49:21'!
createAndCheckOutCartForUserAWithItemSoldQuantity: anQuantityOfitemsSoldByStore
	| cartID |
	
	cartID _ self createEmptyCartForUserA.
	self addToTusLibros: anQuantityOfitemsSoldByStore ofItemSoldByStoreTo: cartID.
	self successfulCheckoutOf: cartID.
	^cartID! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 15:50:05'!
createAndCheckOutCartForUserBWithItemSoldQuantity: anQuantityOfitemsSoldByStore
	| cartID |
	
	cartID _ self createEmptyCartForUserB.
	self addToTusLibros: anQuantityOfitemsSoldByStore ofItemSoldByStoreTo: cartID.
	self successfulCheckoutOf: cartID.
	^cartID! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 03:07:21'!
createCartWithItems
	| cartId |
	cartId _ self createEmptyCartForRegisteredUser.
	self addToTusLibros: 2 ofItemSoldByStoreTo: cartId.
	^ cartId.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 03:30:13'!
createEmptyCartForRegisteredUser
	^self createEmptyCartForUserA! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 03:30:06'!
createEmptyCartForUserA
	^ tusLibrosSystem
		createCartFor: testObjectsFactory userARegisteredOnTusLibros 
		with: testObjectsFactory thePasswordOfUserA .! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 03:30:25'!
createEmptyCartForUserB
	^ tusLibrosSystem
		createCartFor: testObjectsFactory userBRegisteredOnTusLibros 
		with: testObjectsFactory thePasswordOfUserB .! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 01:28:31'!
defaultTusLibrosSystem
	^ TusLibrosSystem
		acceptingItems: testObjectsFactory defaultCatalog
		chargingWith: self
		authenticatingWith: testObjectsFactory defaultUsersAndPasswords
		timingWith: self.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 15:42:52'!
purchasedAmmountOfUserA
	^tusLibrosSystem
		purchasedAmountOf: testObjectsFactory userARegisteredOnTusLibros 
		with: testObjectsFactory thePasswordOfUserA .! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 15:42:58'!
purchasedAmmountOfUserB
	^tusLibrosSystem
		purchasedAmountOf: testObjectsFactory userBRegisteredOnTusLibros 
		with: testObjectsFactory thePasswordOfUserB .! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 03:20:01'!
purchasesOfUserA
	^tusLibrosSystem
		listPurchasesOf: testObjectsFactory userARegisteredOnTusLibros 
		with: testObjectsFactory thePasswordOfUserA .! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/18/2018 15:09:28'!
successfulCheckoutOf: aCartId 
	^tusLibrosSystem
		checkOut: aCartId
		chargingOn: testObjectsFactory dummyCreditCardNumber
		expiringOn: testObjectsFactory aMonthOfTheFuture
		ownedBy: testObjectsFactory dummyName
		on: testObjectsFactory today.! !


!TusLibrosSystemTest methodsFor: 'setup' stamp: 'np 6/18/2018 15:57:46'!
setUp

	testObjectsFactory _ TusLibrosTestObjectsFactory new.
	nowBehaviour _ [ testObjectsFactory december31Of2003 ].
	tusLibrosSystem _ self defaultTusLibrosSystem.! !


!TusLibrosSystemTest methodsFor: 'behavior' stamp: 'DR 6/17/2018 19:05:37'!
debit: anAmount from: aCreditCard 
! !

!TusLibrosSystemTest methodsFor: 'behavior' stamp: 'DR 6/17/2018 22:17:42'!
now
	^nowBehaviour value! !


!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 02:30:51'!
assert: aContainer is: anObject repeatedTimes: aNumberOfTimes
	self assert: aContainer size equals: aNumberOfTimes.
	self assert: (aContainer occurrencesOf: anObject) equals: aNumberOfTimes.
	! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:36:10'!
assert: aContainer isTheItemSoldByStoreRepeated: aQuantity
	self 
		assert: aContainer
		is: (testObjectsFactory itemSellByTheStore)
		repeatedTimes: aQuantity.! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:23:53'!
assertAuthenticationFailedInTusLibrosSystemDoing: aClosure

	self should: aClosure
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 
			TusLibrosSystem failedToAuthenticateClientMessageError ].! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:23:37'!
assertFailureForCheckingOutEmptyCartDoing: aClosure

	self
		should: aClosure
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText 
			= Cashier cartCanNotBeEmptyErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:23:33'!
assertFailureForExpiredCartInTusLibrosSystemDoing: aClosure
	
	self
		should: aClosure
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem expiredCartMessageError ].! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:23:41'!
assertFailureForUnexistingCartInTusLibrosSystemDoing: aClosure

	self
		should: aClosure
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText 
			= TusLibrosSystem unexistingCartErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 02:36:29'!
assertListOf: aCartID isTheItemSoldByStoreRepeated: aQuantity
	self 
		assert: (tusLibrosSystem listCart: aCartID) 
		is: (testObjectsFactory itemSellByTheStore)
		repeatedTimes: aQuantity.! !

!TusLibrosSystemTest methodsFor: 'auxiliar assertions' stamp: 'np 6/18/2018 03:17:41'!
shouldntFail: aClosure
	self
		shouldnt: [ aClosure ]
		raise: Error.! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'np 6/16/2018 02:44:44'!
products

	^items copy! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #SystemCart category: #TusLibros!
Cart subclass: #SystemCart
	instanceVariableNames: 'owner clock lastTimeUsed'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SystemCart methodsFor: 'initialization' stamp: 'DR 6/18/2018 00:49:50'!
initializeAcceptingItemsOf: aCatalog ownedBy: anOwner timedWith: aClock
	super initializeAcceptingItemsOf: aCatalog.
	owner _ anOwner.
	clock _ aClock.
	lastTimeUsed _ clock now.! !


!SystemCart methodsFor: 'timing' stamp: 'DR 6/18/2018 00:45:50'!
assertIIsNotExpiredAndUpdateTimeStamp
	(clock now > (lastTimeUsed next: (TimeUnits minute with: 30)))
		ifTrue: [self error: self class expiredCartMessageError].
	lastTimeUsed _ clock now.! !


!SystemCart methodsFor: 'total' stamp: 'DR 6/18/2018 00:46:28'!
total
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super total! !


!SystemCart methodsFor: 'adding' stamp: 'DR 6/18/2018 00:45:58'!
add: anItem
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super add: anItem.! !

!SystemCart methodsFor: 'adding' stamp: 'DR 6/18/2018 00:46:05'!
add: aQuantity of: anItem
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super add: aQuantity of: anItem! !


!SystemCart methodsFor: 'testing' stamp: 'DR 6/18/2018 00:46:12'!
includes: anItem
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super includes: anItem! !


!SystemCart methodsFor: 'queries' stamp: 'DR 6/18/2018 00:46:19'!
occurrencesOf: anItem
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super occurrencesOf: anItem! !

!SystemCart methodsFor: 'queries' stamp: 'DR 6/18/2018 00:46:23'!
products
	self assertIIsNotExpiredAndUpdateTimeStamp.
	^super products! !


!SystemCart methodsFor: 'owner' stamp: 'DR 6/18/2018 00:57:02'!
owner
	^owner! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SystemCart class' category: #TusLibros!
SystemCart class
	instanceVariableNames: ''!

!SystemCart class methodsFor: 'as yet unclassified' stamp: 'DR 6/18/2018 00:37:46'!
acceptingItemsOf: aCatalog ownedBy: anOwner timedWith: aClock

	^ self new initializeAcceptingItemsOf: aCatalog ownedBy: anOwner timedWith: aClock.! !

!SystemCart class methodsFor: 'as yet unclassified' stamp: 'DR 6/18/2018 00:42:17'!
expiredCartMessageError

	^'Se te venció el changito'! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'np 6/16/2018 02:42:26'!
initializeWith: aCreditCardNumber expiringOn: aMonthOfAnYear ownedBy: aCreditCardOwner 	

	expiration := aMonthOfAnYear.
	number _ aCreditCardNumber .
	owner _ aCreditCardOwner .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'np 6/16/2018 02:42:08'!
with: aCreditCardNumber expiringOn: aMonthOfAnYear ownedBy: aCreditCardOwner
	
	^self new initializeWith: aCreditCardNumber expiringOn: aMonthOfAnYear ownedBy: aCreditCardOwner ! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #TusLibrosSystem category: #TusLibros!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'clientsInfo lastCartID catalog systemCarts merchantProcessor purchasedBooks clock purchasedAmmounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:02:31'!
add: aQuantity of: anISBN to: aCartId

	self assertExistingCart: aCartId.
		
	(systemCarts at: aCartId)
		add: aQuantity
		of: anISBN.! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'np 6/18/2018 15:56:50'!
checkOut: aCartID chargingOn: aCreditCardNumber expiringOn: aMonthOfAnYear ownedBy: aCreditCardOwner on: aDate

	| cart creditCard cashier owner total |
	
	self assertExistingCart: aCartID.
		
	cart _ systemCarts at: aCartID.
		
	creditCard _ CreditCard 
		with: aCreditCardNumber 
		expiringOn: aMonthOfAnYear 
		ownedBy: aCreditCardOwner.
		
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: merchantProcessor
		on: aDate
		registeringOn: OrderedCollection new.
	
	total _ cashier checkOut.
	
	owner _ (systemCarts at: aCartID) owner.
	(purchasedBooks at: owner) addAll: cart products.
	purchasedAmmounts at: owner put: ((purchasedAmmounts at: owner) + total).
	
	systemCarts removeKey: aCartID.
	^aCartID

	

		! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'np 6/18/2018 15:57:09'!
createCartFor: aClientID with: aPassword
	| cartId |
	
	self authenticate: aClientID using: aPassword.
		
	lastCartID _ lastCartID + 1.
	cartId _ lastCartID.
	
	systemCarts
		at: cartId
		put: (SystemCart acceptingItemsOf: catalog ownedBy: aClientID timedWith: clock).
		
	^ cartId.! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:03:10'!
listCart: aCartId

	self assertExistingCart: aCartId.
	
	^(systemCarts at: aCartId) products.! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'np 6/18/2018 15:27:45'!
listPurchasesOf: aClientID with: aPassword

	^ (purchasedBooks at: aClientID) copy! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'np 6/18/2018 15:28:01'!
purchasedAmountOf: aClientID with: aPassword

	^ (purchasedAmmounts at: aClientID) copy! !


!TusLibrosSystem methodsFor: 'authentication' stamp: 'DR 6/17/2018 20:10:46'!
authenticate: aClientID using: aPassword

	((clientsInfo includesKey: aClientID) and: [(clientsInfo at: aClientID) = aPassword])
		ifFalse: [self error: self class failedToAuthenticateClientMessageError]
	! !


!TusLibrosSystem methodsFor: 'initialization' stamp: 'np 6/18/2018 15:28:31'!
initializeAcceptingItems: aCatalog chargingWith: aMerchantProcessor authenticatingWith: clientIDsAndPasswords timingWith: aClock

	lastCartID _ 0.
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	clock _ aClock.
	
	clientsInfo _ clientIDsAndPasswords.
	purchasedAmmounts _ Dictionary new.
	purchasedBooks _ Dictionary new.
	clientIDsAndPasswords keys do: [ :clientID |
		purchasedAmmounts at: clientID put: 0.
		purchasedBooks at: clientID put: Bag new.
	].
	
	systemCarts _ Dictionary new.! !


!TusLibrosSystem methodsFor: 'asserts' stamp: 'DR 6/18/2018 01:02:47'!
assertExistingCart: aCartId.

	(systemCarts includesKey: aCartId)
		ifFalse: [ self error: self class unexistingCartErrorMessage ].
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: #TusLibros!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'DR 6/17/2018 21:48:41'!
acceptingItems: aCatalog chargingWith: aMerchantProcessor authenticatingWith: clientIDsAndPasswords timingWith: aClock

	^self new initializeAcceptingItems: aCatalog chargingWith: aMerchantProcessor authenticatingWith: clientIDsAndPasswords timingWith: aClock
! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'DR 6/17/2018 21:55:43'!
expiredCartMessageError

	^'Se te venció el changito'! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 01:09:46'!
failedToAuthenticateClientMessageError

	^'Usuario o contraseña inválidos.'! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 01:10:03'!
unexistingCartErrorMessage

	^'No existe un carro con ese ID'! !


!classDefinition: #TusLibrosTestObjectsFactory category: #TusLibros!
Object subclass: #TusLibrosTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!TusLibrosTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!TusLibrosTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!TusLibrosTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!TusLibrosTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!TusLibrosTestObjectsFactory methodsFor: 'credit card' stamp: 'DR 6/17/2018 19:47:18'!
aMonthInThe1800s

	^Month month: today monthIndex year: 1800! !

!TusLibrosTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/16/2018 03:28:52'!
aMonthOfTheFuture

	^Month month: today monthIndex year: today yearNumber + 1! !

!TusLibrosTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/18/2018 01:29:17'!
dummyCreditCardNumber
	^123465756454! !

!TusLibrosTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/18/2018 01:38:07'!
expiredCreditCard
	
	^CreditCard 
		with: self dummyCreditCardNumber
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1)
		ownedBy: 'Marley'! !

!TusLibrosTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/18/2018 01:38:14'!
notExpiredCreditCard
	
	^CreditCard 
		with: self dummyCreditCardNumber
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1)
		ownedBy: 'Noit'! !


!TusLibrosTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!TusLibrosTestObjectsFactory methodsFor: 'date' stamp: 'np 6/18/2018 01:27:12'!
december31Of2003
	^GregorianDateTime
		date: (FixedGregorianDate yearNumber: 2003 monthNumber: 12 dayNumber: 31)
		timeOfDay: (TimeOfDay  hours: 00)! !

!TusLibrosTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 01:25:57'!
aUserNotRegisteredOnTusLibros
	^'Emilio'! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:43:59'!
aUserRegisteredOnTusLibros
	^self userARegisteredOnTusLibros ! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:44:39'!
defaultUsersAndPasswords
	
	^Dictionary
		with: (self userARegisteredOnTusLibros )->(self thePasswordOfUserA)
		with: (self userBRegisteredOnTusLibros )->(self thePasswordOfUserB)! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 01:29:25'!
dummyName
	^'José Luis Miguel'! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 01:29:32'!
dummyPassword
	^'pass'! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:43:05'!
thePasswordOfUserA
	^1234! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:43:10'!
thePasswordOfUserB
	^1111! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:42:03'!
userARegisteredOnTusLibros
	^'Jorge'! !

!TusLibrosTestObjectsFactory methodsFor: 'system' stamp: 'np 6/18/2018 02:43:27'!
userBRegisteredOnTusLibros
	^'Manuelita'! !
