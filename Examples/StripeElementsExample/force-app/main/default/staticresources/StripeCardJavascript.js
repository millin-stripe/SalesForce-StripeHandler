j$ = jQuery.noConflict();
var stripe;
var elements;
var card;

//We pas the client secret to this page via a URL Parameter
const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const client_key = urlParams.get('clientSecret')

j$(document).ready( function () {


	// Set Publishable key of your Stripe Account. This could be called other way but in this example we just have it hard coded. 
    stripe = Stripe('pk_test_key');
	elements = stripe.elements();
	var style = {
	    base: {
	// Customize the Card Form.You can change the style of the Card.
		color: '#32325d',
		lineHeight: '18px',
		fontFamily: '"Helvetica Neue", Helvetica, sans-serif',
		fontSmoothing: 'antialiased',
		fontSize: '16px',
		'::placeholder': {
		  color: '#aab7c4'
		}
	    },
	    invalid: {
		color: '#fa755a',
		iconColor: '#fa755a'
	    }
	};

	// Create card Element
	card = elements.create('card', {style: style});

	// Add card Element into the 'cardElement'
     card.mount('#cardElement'); 

    // Handle validation errors from the card Element. 
    card.addEventListener('change', function(event) { 
        var displayCardError = document.getElementById('cardErrors'); 
        // get cardErrors Div 
        if (event.error) { 
            // Show Validation errors 
            displayCardError.textContent = event.error.message; 
        } 
        else { 
            displayCardError.textContent = ""; 
        } 
    }); 
}); 
function validateCard(){ 
    const queryString = window.location.search;
    const urlParams = new URLSearchParams(queryString);
    const client_key = urlParams.get('clientSecret')
    stripe.confirmCardPayment(
        client_key,{
            payment_method: {
                card: card,
              }
        })
        .then(function(result) {
         if(result.error) { 
             // Display errors in the ‘cardErrors’ Div 
             var errorElement = document.getElementById('cardErrors'); 
             errorElement.textContent = result.error.message; 
            } 
        else { 
            console.log('====success ==='+JSON.stringify(result.paymentIntent));
             // Generate Card Token and get Token Id 
             generateToken(result.paymentIntent); } 
    }); 
} 
function generateToken(intent){ 
    var tokenId = JSON.stringify(intent.id); alert('Your Payment Intent ID: ' + intent.id); 
}