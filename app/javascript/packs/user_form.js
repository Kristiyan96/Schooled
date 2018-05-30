import Vue from 'vue/dist/vue.esm'
import TurbolinksAdapter from 'vue-turbolinks'
import VueResource from 'vue-resource'

Vue.use(VueResource)
Vue.use(TurbolinksAdapter)

document.addEventListener('turbolinks:load', () => {
  Vue.http.headers.common['X-CSRF-Token'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content')

  var element = document.getElementById("user-form")
  if (element != null) {
    var id = element.dataset.id
    var user = JSON.parse(element.dataset.user)

    var app = new Vue({
      el: element,
      data: function() {
        return { id: id, user: user }
      },
      methods: {
        saveUser: function() {
          this.$http.put("/users", { user: this.user }).then(response => {
            Turbolinks.visit('/profiles/'+this.id)
          }, response => {
            console.log(response)
          })
        }
      }
    })
  }
})