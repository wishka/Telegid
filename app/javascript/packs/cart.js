function add_to_cart(id, id2, id3) {
    var key = "username's mix(" + id + ")";
    var x = window.localStorage.getItem(key);
    x++;
    window.localStorage.setItem(key, x);

    update_orders_input();
    update_orders_button();
  }
  function update_orders_input() {
    var orders = cart_get_orders ();
    $('#orders_input').val(orders);
  }

  function update_orders_button() {
    var text = cart_get_number_of_items();
    $('#orders_button').val(orders);
  }
  function cart_get_number_of_items (){
    var cnt = 0;
    for(var i = 0; i < window.localStorage.length; i++)
    {
      var key = window.localStorage.key(i); // получаем ключ
      var value = window.localStorage.getItem(key); //получаем значение

      if(key.indexof("username's mix(" + id + "," + id2 + "," + id3 + ")") == 0){
        cnt = cnt + value * 1;
      }
      return cnt;
    }
  }

  /* Получаем информацию о кол-ве заказов*/
  function cart_get_orders (){
    var cnt = "";
    for(var i = 0; i < window.localStorage.length; i++)
    {
      var key = window.localStorage.key(i); // получаем ключ
      var value = window.localStorage.getItem(key); //получаем значение

      if(key.indexof("username's mix(" + id + "," + id2 + "," + id3 + ")") == 0){
        orders = orders + key + "=" + value + ",";
      }
    }
    return orders;
  }

  // Функция для очистки корзины заказа
  function cancel_order() {
    window.localStorage.clear();
    update_orders_input();
    update_orders_button();

    $('#cart_stor').text('Your cart is empty!');

    return false;
  }
