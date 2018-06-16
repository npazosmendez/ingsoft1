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
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:46:02'!
test01CanCreateCartOnSuccesfulAuthentication
	| tusLibros |
	
	tusLibros _ self createTusLibrosSystem.

	self shouldnt: [ self createCartForTheUserIn: tusLibros ] raise: Error.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:48:32'!
test02CanNotCreateCartOnFailedAuthentication
	| tusLibros |

	tusLibros _ self createTusLibrosSystem.
	
	self
		should: [
			tusLibros
				createCartFor: self aUserNotRegisteredOnTusLibros
				with: self thePasswordOfTheUserOfTusLibros]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem failedToAuthenticateClientMessageError].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 02:59:32'!
test03CanNotListUnexistantCart
	| cartId tusLibros |

	tusLibros _ self createTusLibrosSystem.
	cartId _ 0.
	
	self
		should: [ tusLibros listCart: cartId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = TusLibrosSystem unexistingCartErrorMessage ].! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:46:27'!
test04NewCartListIsEmpty
	| tusLibros cartId  |
	
	tusLibros _ self createTusLibrosSystem.
	
	cartId _ self createCartForTheUserIn: tusLibros.
	
	self assert: (tusLibros listCart: cartId) isEmpty.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:46:40'!
test05ProductsAddedToTheCartAreListed
	| tusLibros cartId  aQuantity booksInCart |
	
	tusLibros _ self createTusLibrosSystem.
	
	cartId _ self createCartForTheUserIn: tusLibros.
	
	aQuantity _ 5.
	tusLibros add: aQuantity of: testObjectsFactory itemSellByTheStore to: cartId .
	
	booksInCart  _ tusLibros listCart: cartId .
	
	self assert: booksInCart size equals: aQuantity.
	self assert: (booksInCart occurrencesOf: testObjectsFactory itemSellByTheStore) equals: aQuantity.! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:33:26'!
test06CanNotAddProductsToUnexistantCart
	| tusLibros cartId  |

	tusLibros _ self createTusLibrosSystem .
	
	cartId _ 846455.
	
	self 
		should: [tusLibros add: 3 of: testObjectsFactory itemSellByTheStore to: cartId ]
		raise: Error -  MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TusLibrosSystem unexistingCartErrorMessage.
		].
! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:47:10'!
test07CanCreateMoreThanOneEmptyCart
	| tusLibros  aCartID anotherCartID |
	
	tusLibros _ self createTusLibrosSystem .
	
	aCartID _ self createCartForTheUserIn: tusLibros.
	anotherCartID _ self createCartForTheUserIn: tusLibros.
	
	self deny: aCartID = anotherCartID.
	self assert: (tusLibros listCart: aCartID) isEmpty.
	self assert: (tusLibros listCart: anotherCartID) isEmpty.
	! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:09:48'!
test08CanAddProductsToDifferentCarts
	| tusLibros  aCartID anotherCartID |
	
	tusLibros _ self createTusLibrosSystem.
	
	aCartID _	self createCartForTheUserIn: tusLibros.		
	anotherCartID _ self createCartForTheUserIn: tusLibros.
	
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

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:36:23'!
test09
	| tusLibros clientsIDsAndPasswords aPassword  aClientID anotherClientID anotherPassword aCartID anotherCartID |
	
	aClientID _ 'Jorge'.
	aPassword _ 1234.
	anotherClientID _ 'Emilio'.
	anotherPassword _ 5678.
	
	clientsIDsAndPasswords _ Dictionary with: aClientID->aPassword with: anotherClientID->anotherPassword.
	
	tusLibros _ TusLibrosSystem
		acceptingItems: testObjectsFactory defaultCatalog 
		authenticatingWith: clientsIDsAndPasswords.
	
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

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:38:42'!
test10CanNotCheckOutUnexistantCart
	| tusLibros cartId  creditCardNumber aMonthOfAnYear |

	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture .
	
	tusLibros _ self createTusLibrosSystem.
	cartId _ 0.
		
	self 
		should: [
			tusLibros 
				checkOut: cartId 
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: TusLibrosSystem unexistingCartErrorMessage 
			]! !

!TusLibrosSystemTest methodsFor: 'tests' stamp: 'np 6/16/2018 03:39:24'!
test11CanNotCheckOutEmptyCart
	| tusLibros cartId  creditCardNumber aMonthOfAnYear |

	creditCardNumber _ 123465756454.
	aMonthOfAnYear _ testObjectsFactory aMonthOfTheFuture .
	
	tusLibros _ self createTusLibrosSystem.
	cartId _ self createCartForTheUserIn: tusLibros.
	
	self 
		should: [
			tusLibros 
				checkOut: cartId 
				chargingOn: creditCardNumber
				expiringOn: aMonthOfAnYear
				ownedBy: 'José Luis Miguel'
				]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: Cashier cartCanNotBeEmptyErrorMessage
			]! !


!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:56:09'!
aUserNotRegisteredOnTusLibros
	^'Emilio'! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:54:55'!
aUserRegisteredOnTusLibros
	^'Jorge'! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 03:06:29'!
createCartForTheUserIn: tusLibrosSystem

	^tusLibrosSystem
		createCartFor: self aUserRegisteredOnTusLibros 
		with: self thePasswordOfTheUserOfTusLibros .! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:59:19'!
createTusLibrosSystem

	^TusLibrosSystem 
		acceptingItems: testObjectsFactory defaultCatalog 
		authenticatingWith: self defaultUsersAndPasswords! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 03:01:07'!
defaultUsersAndPasswords
	
	^Dictionary with: (self aUserRegisteredOnTusLibros)->(self thePasswordOfTheUserOfTusLibros).! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:30:25'!
setUp
	testObjectsFactory := StoreTestObjectsFactory new.
! !

!TusLibrosSystemTest methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 03:00:59'!
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
	instanceVariableNames: 'IDsAndPasswords lastCartID catalog cartsAndProducts merchantProcessor salesBook'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:45:57'!
add: aQuantity of: anISBN to: aCartId
	(cartsAndProducts
		at: aCartId
		ifAbsent: [ self error: self class unexistingCartErrorMessage ])
		add: aQuantity
		of: anISBN.! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 01:31:29'!
authenticate: aClientID using: aPassword

	(IDsAndPasswords at: aClientID ifAbsent: []) = aPassword 
		ifFalse: [self error: self class failedToAuthenticateClientMessageError]
	! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 03:22:36'!
checkOut: aCartID chargingOn: aCreditCardNumber expiringOn: aMonthOfAnYear ownedBy: aCreditCardOwner 

	| cart creditCard cashier |
	
	cart _ cartsAndProducts
		at: aCartID
		ifAbsent: [ self error: self class unexistingCartErrorMessage ].
		
	creditCard _ CreditCard 
		with: aCreditCardNumber 
		expiringOn: aMonthOfAnYear 
		ownedBy: aCreditCardOwner.
		
	cashier _ Cashier
		toCheckout: cart
		charging: creditCard
		throught: merchantProcessor
		on: Date today
		registeringOn: salesBook.
		
	cashier checkOut.
	
	^0

	

		! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:45:57'!
createCartFor: aClientID with: aPassword
	| cartId |
	self
		authenticate: aClientID
		using: aPassword.
	lastCartID _ lastCartID + 1.
	cartId _ lastCartID.
	cartsAndProducts
		at: cartId
		put: (Cart acceptingItemsOf: catalog).
	^ cartId.! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:47:26'!
initializeAcceptingItems: aCatalog authenticatingWith: clientIDsAndPasswords
	IDsAndPasswords _ clientIDsAndPasswords.
	lastCartID _ 0.
	cartsAndProducts _ Dictionary new.
	catalog _ aCatalog.! !

!TusLibrosSystem methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:45:57'!
listCart: aCartId
	^ (cartsAndProducts
		at: aCartId
		ifAbsent: [ self error: self class unexistingCartErrorMessage ]) products.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystem class' category: #TusLibros!
TusLibrosSystem class
	instanceVariableNames: ''!

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 02:48:04'!
acceptingItems: aCatalog authenticatingWith: clientIDsAndPasswords

	^self new initializeAcceptingItems: aCatalog authenticatingWith: clientIDsAndPasswords
! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 01:09:46'!
failedToAuthenticateClientMessageError

	^'Usuario o contraseña inválidos.'! !

!TusLibrosSystem class methodsFor: 'as yet unclassified' stamp: 'np 6/16/2018 01:10:03'!
unexistingCartErrorMessage

	^'No existe un carro con ese ID'! !
