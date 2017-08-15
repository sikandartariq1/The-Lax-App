document.addEventListener("turbolinks:load", function(){

  var stripe = Stripe($('meta[name="stripe-key"]').attr('content'));
  var elements = stripe.elements();

  var style = {
    base: {
      color: '#32325d',
      lineHeight: '24px',
      fontFamily: 'Helvetica Neue',
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

  var card = elements.create('card', {style: style});
  card.mount('#card-element');

  card.addEventListener('change', function(event) {
    const displayError = document.getElementById('card-errors');
    if (event.error) {
      displayError.textContent = event.error.message;
    } else {
      displayError.textContent = '';
    }
  });

  // Handle form submission
  var form = document.getElementById('payment-form');
  form.addEventListener('submit', function(event) {
    event.preventDefault();

    stripe.createToken(card).then(function(result) {
      if (result.error) {
        var errorElement = document.getElementById('card-errors');
        errorElement.textContent = result.error.message;
      }
      else {
        var form = document.getElementById('payment-form');
        var hiddenInput = document.createElement('input');
        hiddenInput.setAttribute('type', 'hidden');
        hiddenInput.setAttribute('name', 'stripeToken');
        hiddenInput.setAttribute('value', result.token.id);
        form.appendChild(hiddenInput);
        form.submit();
      }
    });
  });
});
