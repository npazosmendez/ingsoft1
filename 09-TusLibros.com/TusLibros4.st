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


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


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


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosSystemTest category: #TusLibros!
TestCase subclass: #TusLibrosSystemTest
	instanceVariableNames: 'testObjectsFactory nowBehaviour'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 21:01:59'!
test01CanCreateCartOnSuccesfulAuthentication
	| tusLibros |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	self
		shouldnt: [ self emptyCartIn: tusLibros ]
		raise: Error - MessageNotUnderstood.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 21:02:25'!
test02UnregisteredUserCanNotCreateCart
	| tusLibros |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	self
		should: [
			tusLibros
				createCartFor: self aUserNotRegisteredOnTusLibros
				with: self dummyPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem failedToAuthenticateClientMessageError ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 21:02:44'!
test02bRegisteredUserWithIncorrentPasswordCanNotCreateCart
	| tusLibros |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	self
		should: [
			tusLibros
				createCartFor: self aUserRegisteredOnTusLibros
				with: 'Wrong password' ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem failedToAuthenticateClientMessageError ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 21:02:52'!
test03CanNotListUnexistantCart
	| cartId tusLibros |
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ 0.
	
	self
		should: [ tusLibros listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem unexistingCartErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 15:35:06'!
test03bCanNotAddBooksToUnexistantCart
	| tusLibros cartId |
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ 846455.
	self
		should: [
			tusLibros
				add: 3
				of: testObjectsFactory itemSellByTheStore
				to: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: TusLibrosSystem unexistingCartErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:19'!
test04BookListOfNewCartIsEmpty
	| tusLibros cartId |
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self emptyCartIn: tusLibros.
	self assert: (tusLibros listCart: cartId) isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:19'!
test05BooksAddedToTheCartAreListed
	| tusLibros cartId aQuantity booksInCart |
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self emptyCartIn: tusLibros.
	aQuantity _ 5.
	tusLibros
		add: aQuantity
		of: testObjectsFactory itemSellByTheStore
		to: cartId.
	booksInCart _ tusLibros listCart: cartId.
	self
		assert: booksInCart size
		equals: aQuantity.
	self
		assert: (booksInCart occurrencesOf: testObjectsFactory itemSellByTheStore)
		equals: aQuantity.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:19'!
test07AUserCanCreateMoreThanOneEmptyCart
	| tusLibros aCartID anotherCartID |
	tusLibros _ self defaultTusLibrosSystem.
	aCartID _ self emptyCartIn: tusLibros.
	anotherCartID _ self emptyCartIn: tusLibros.
	self deny: aCartID = anotherCartID.
	self assert: (tusLibros listCart: aCartID) isEmpty.
	self assert: (tusLibros listCart: anotherCartID) isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:19'!
test08BooksAddedToMultipleCartsByAUserGetListedInTheirRespectiveCarts
	| tusLibros aCartID anotherCartID |
	tusLibros _ self defaultTusLibrosSystem.
	aCartID _ self emptyCartIn: tusLibros.
	anotherCartID _ self emptyCartIn: tusLibros.
	tusLibros
		add: 3
		of: testObjectsFactory itemSellByTheStore
		to: aCartID.
	tusLibros
		add: 5
		of: testObjectsFactory itemSellByTheStore
		to: anotherCartID.
	self
		assert: (tusLibros listCart: aCartID) size
		equals: 3.
	self
		assert: ((tusLibros listCart: aCartID) occurrencesOf: testObjectsFactory itemSellByTheStore)
		equals: 3.
	self
		assert: (tusLibros listCart: anotherCartID) size
		equals: 5.
	self
		assert: ((tusLibros listCart: anotherCartID) occurrencesOf: testObjectsFactory itemSellByTheStore)
		equals: 5.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 21:48:18'!
test09BooksAddedByMultipleUsersGetListedInTheirRespectiveCarts
	| tusLibros clientsIDsAndPasswords aPassword  aClientID anotherClientID anotherPassword aCartID anotherCartID |
	
	aClientID _ 'Jorge'.
	aPassword _ 1234.
	anotherClientID _ 'Emilio'.
	anotherPassword _ 5678.
	
	clientsIDsAndPasswords _ Dictionary with: aClientID->aPassword with: anotherClientID->anotherPassword.
	
	tusLibros _ TusLibrosSystem
		acceptingItems: testObjectsFactory defaultCatalog 
		chargingWith: self
		authenticatingWith: clientsIDsAndPasswords
		timingWith: self.
	
	aCartID _ tusLibros createCartFor: aClientID with: aPassword .
	anotherCartID _ tusLibros createCartFor: anotherClientID with: anotherPassword.
	
	tusLibros add: 3 of: testObjectsFactory itemSellByTheStore to: aCartID.
	tusLibros add: 5 of: testObjectsFactory itemSellByTheStore to: anotherCartID.
	
	self assert: (tusLibros listCart: aCartID) size equals: 3.
	self 
		assert: ((tusLibros listCart: aCartID) occurrencesOf: testObjectsFactory itemSellByTheStore) 
		equals: 3.
	
	self assert: (tusLibros listCart: anotherCartID) size equals: 5.
	self 
		assert: ((tusLibros listCart: anotherCartID) occurrencesOf: testObjectsFactory itemSellByTheStore)
		equals: 5.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:37'!
test10CanNotCheckOutUnexistantCart
	| tusLibros cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ 0.
	
	self
		should: [
			tusLibros
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				on: testObjectsFactory today. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: TusLibrosSystem unexistingCartErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:35'!
test11CanNotCheckOutEmptyCart
	| tusLibros cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self emptyCartIn: tusLibros.
	
	self
		should: [
			tusLibros
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				on: testObjectsFactory today ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self
				assert: anError messageText
				equals: Cashier cartCanNotBeEmptyErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 20:00:33'!
test12CanCheckOutNonEmptyCart
	| tusLibros cartId creditCardNumber aMonthOfAnYear |
	
	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture.
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self cartWithItemsIn: tusLibros.
	
	self
		shouldnt: [
			tusLibros
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				on: testObjectsFactory today.
			 ]
		raise: Error - MessageNotUnderstood.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 19:58:44'!
test13CanCheckOutCartWithUnexpiredCreditCardInThePast
	| tusLibros cartId creditCardNumber expirationMonth |
	
	creditCardNumber _ 123465756454.
	expirationMonth _ testObjectsFactory aMonthInThe1800s.
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self cartWithItemsIn: tusLibros.
	
	self
		shouldnt: [
			tusLibros
				checkOut: cartId
				chargingOn: creditCardNumber
				expiringOn: expirationMonth
				ownedBy: 'José Luis Miguel'
				on: (DateAndTime year: 1800 day: 0).
			 ]
		raise: Error - MessageNotUnderstood.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/18/2018 01:14:46'!
test14PurchasesOfAUserOnANewSystemAreEmpty
	| tusLibros purchases |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	purchases _ tusLibros
		listPurchasesOf: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.
	
	self assert: purchases isEmpty
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 22:19:50'!
test15BooksOfASingleCheckoutCartAreListedInPurchases
	| tusLibros cartId purchases |
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self emptyCartIn: tusLibros.
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
	
	self successfulCheckoutOf: cartId in: tusLibros.
	
	purchases _ tusLibros
		listPurchasesOf: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.
	
	self assert: purchases size equals: 2.
	self assert: (purchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 2.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 22:19:36'!
test16BooksOfMultipleCheckoutCartsAreListedInPurchases
	| tusLibros cartId purchases |
	
	tusLibros _ self defaultTusLibrosSystem.
	cartId _ self emptyCartIn: tusLibros.
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
		
	self successfulCheckoutOf: cartId in: tusLibros.
	self successfulCheckoutOf: cartId in: tusLibros.
	
	purchases _ tusLibros
		listPurchasesOf: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.
	
	self assert: purchases size equals: 4.
	self assert: (purchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 4.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 22:20:34'!
test17BooksBoughtByDifferentUsersGetListedInTheirRespectiveLists
	| tusLibros firstCartId secondCartId firstPurchases secondPurchases |
	
	tusLibros _ self defaultTusLibrosSystem.

	firstCartId _ tusLibros
		createCartFor: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.
	tusLibros add: 1 of: testObjectsFactory itemSellByTheStore to: firstCartId.
	self successfulCheckoutOf: firstCartId in: tusLibros.
	
	secondCartId _ tusLibros
		createCartFor: 'Marianuli'
		with: 1111.
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: secondCartId.
	self successfulCheckoutOf: secondCartId in: tusLibros.
	
	firstPurchases _ tusLibros
		listPurchasesOf: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.

	secondPurchases _ tusLibros
		listPurchasesOf: 'Marianuli'
		with: 1111.
	
	self assert: firstPurchases size equals: 1.
	self assert: (firstPurchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 1.

	self assert: secondPurchases size equals: 2.
	self assert: (secondPurchases occurrencesOf: testObjectsFactory itemSellByTheStore) equals: 2.

	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/18/2018 00:57:37'!
test18ExpiredCartCanNotBeListed
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		should: [ tusLibros listCart: cartId. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem expiredCartMessageError ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 23:40:01'!
test19ExpiredCartCanNotBeAddedTo
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		should: [ tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem expiredCartMessageError ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 23:40:12'!
test20ExpiredCartCanNotBeCheckout
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		should: [
			tusLibros
				checkOut: cartId
				chargingOn: self dummyCreditCardNumber
				expiringOn: testObjectsFactory aMonthOfTheFuture
				ownedBy: self dummyName
				on: testObjectsFactory today. ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem expiredCartMessageError ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 23:41:11'!
test21ListingCartExtendsItsExpirationDeadline
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.
	
	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 15) ].
	
	tusLibros listCart: cartId.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		shouldnt: [
			tusLibros listCart: cartId. ]
		raise: Error - MessageNotUnderstood! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 23:41:22'!
test22AddingToCartExtendsItsExpirationDeadline
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.
	
	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 15) ].
	
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		shouldnt: [
			tusLibros listCart: cartId. ]
		raise: Error - MessageNotUnderstood! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'DR 6/17/2018 23:41:35'!
test23CheckingOutCartExtendsItsExpirationDeadline
	| tusLibros cartId |
	
	tusLibros _ self defaultTusLibrosSystem.
	
	nowBehaviour _ [ self december31Of2003 ].
	
	cartId _ self emptyCartIn: tusLibros.
	tusLibros add: 2 of: testObjectsFactory itemSellByTheStore to: cartId.
		
	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 15) ].
	
	self successfulCheckoutOf: cartId in: tusLibros.

	nowBehaviour _ [ self december31Of2003 next: (TimeUnits minute with: 31) ].
	
	self 
		shouldnt: [
			tusLibros listCart: cartId. ]
		raise: Error - MessageNotUnderstood! !


!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/16/2018 02:56:09'!
aUserNotRegisteredOnTusLibros
	^'Emilio'! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/16/2018 02:54:55'!
aUserRegisteredOnTusLibros
	^'Jorge'! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:00:19'!
cartWithItemsIn: tusLibros
	| cartId |
	cartId _ self emptyCartIn: tusLibros.
	tusLibros
		add: 2
		of: testObjectsFactory itemSellByTheStore
		to: cartId.
	^ cartId.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 19:05:37'!
debit: anAmount from: aCreditCard 
! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 22:09:47'!
december31Of2003
	^GregorianDateTime
		date: (FixedGregorianDate yearNumber: 2003 monthNumber: 12 dayNumber: 31)
		timeOfDay: (TimeOfDay  hours: 00)! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 21:48:06'!
defaultTusLibrosSystem
	^ TusLibrosSystem
		acceptingItems: testObjectsFactory defaultCatalog
		chargingWith: self
		authenticatingWith: self defaultUsersAndPasswords
		timingWith: self.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:34:19'!
defaultUsersAndPasswords
	
	^Dictionary
		with: (self aUserRegisteredOnTusLibros)->(self thePasswordOfTheUserOfTusLibros)
		with: 'Marianuli'->1111.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:02:31'!
dummyCreditCardNumber
	^123465756454! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:01:17'!
dummyName
	^'José Luis Miguel'! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 15:17:11'!
dummyPassword
	^'pass'! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:00:19'!
emptyCartIn: tusLibrosSystem
	^ tusLibrosSystem
		createCartFor: self aUserRegisteredOnTusLibros
		with: self thePasswordOfTheUserOfTusLibros.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 22:17:42'!
now
	^nowBehaviour value! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 22:16:07'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.
	nowBehaviour _ [ self december31Of2003 ].
! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'DR 6/17/2018 20:28:48'!
successfulCheckoutOf: aCartId in: tusLibrosSystem
	tusLibrosSystem
		checkOut: aCartId
		chargingOn: self dummyCreditCardNumber
		expiringOn: testObjectsFactory aMonthOfTheFuture
		ownedBy: self dummyName
		on: testObjectsFactory today.! !

!TusLibrosSystemTest methodsFor: 'support' stamp: 'np 6/16/2018 03:00:59'!
thePasswordOfTheUserOfTusLibros
	^1234! !


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


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'DR 6/17/2018 19:47:18'!
aMonthInThe1800s

	^Month month: today monthIndex year: 1800! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/16/2018 03:28:52'!
aMonthOfTheFuture

	^Month month: today monthIndex year: today yearNumber + 1! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/16/2018 03:26:41'!
expiredCreditCard
	
	^CreditCard 
		with: 12345
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1)
		ownedBy: 'Marley'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'np 6/16/2018 03:27:23'!
notExpiredCreditCard
	
	^CreditCard 
		with: 1234
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1)
		ownedBy: 'Noit'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosSystem category: #TusLibros!
Object subclass: #TusLibrosSystem
	instanceVariableNames: 'clientsInfo lastCartID catalog systemCarts merchantProcessor purchasedBooks clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:02:31'!
add: aQuantity of: anISBN to: aCartId

	self assertExistingCart: aCartId.
		
	(systemCarts at: aCartId)
		add: aQuantity
		of: anISBN.! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:06:03'!
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
	
	^total

	

		! !

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:05:23'!
createCartFor: aClientID with: aPassword
	| cartId |
	
	self
		authenticate: aClientID
		using: aPassword.
		
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

!TusLibrosSystem methodsFor: 'interface' stamp: 'DR 6/18/2018 01:10:47'!
listPurchasesOf: aClientID with: aPassword

	^ (purchasedBooks at: aClientID) copy! !


!TusLibrosSystem methodsFor: 'authentication' stamp: 'DR 6/17/2018 20:10:46'!
authenticate: aClientID using: aPassword

	((clientsInfo includesKey: aClientID) and: [(clientsInfo at: aClientID) = aPassword])
		ifFalse: [self error: self class failedToAuthenticateClientMessageError]
	! !


!TusLibrosSystem methodsFor: 'initialization' stamp: 'DR 6/18/2018 00:59:22'!
initializeAcceptingItems: aCatalog chargingWith: aMerchantProcessor authenticatingWith: clientIDsAndPasswords timingWith: aClock

	lastCartID _ 0.
	catalog _ aCatalog.
	merchantProcessor _ aMerchantProcessor.
	clock _ aClock.
	
	clientsInfo _ clientIDsAndPasswords.
	purchasedBooks _ Dictionary new.
	clientIDsAndPasswords keys do: [ :clientID |
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
