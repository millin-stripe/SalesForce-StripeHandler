j$ = jQuery.noConflict();
var stripe;
var elements;
var card;
var paymentElement;
const queryString = window.location.search;
const urlParams = new URLSearchParams(queryString);
const client_key = urlParams.get('clientSecret')
j$(document).ready( function () {
	// Set Publishable key of your Stripe Account.
stripe = Stripe('pk_test_51JFfvjKIX4HOzg7MJ70vlPxmeqA5eGm6n8xebat88fb6E4cKu5Q95BzR7gV02rYQaZ29xUFFHwECVO5Yl8JKZnoy00VL3iwQkr');
const options = {
    clientSecret: client_key,
  };
  elements = stripe.elements(options);

  paymentElement = elements.create("payment");
  paymentElement.mount("#payment-element");
    // Handle validation errors from the card Element. 
    paymentElement.addEventListener('change', function(event) { 
        var displayCardError = document.getElementById('payment-element-Errors'); 
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
    const {error} = stripe.confirmPayment({
        elements,
        confirmParams: {
          return_url: 'https://www.google.com',
        },
    
        // Uncomment below if you only want redirect for redirect-based payments
        redirect: 'if_required',
    }
      )
        .then(function(result) {
         if(error) { 
             // Display errors in the ‘cardErrors’ Div 
             var errorElement = document.getElementById('payment-element-Errors'); 
             errorElement.textContent = error.message; 
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