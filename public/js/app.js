var app = new Vue({
	el: '#app',
	data: {
		login: '',
		pass: '',
		post: false,
		invalidLogin: false,
		invalidPass: false,
		invalidSum: false,
		invalidText: false,
		posts: [],
		addSum: 0,
		amount: 0,
		likes: 0,
		commentText: '',
		packs: [
			{
				id: 1,
				price: 5
			},
			{
				id: 2,
				price: 20
			},
			{
				id: 3,
				price: 50
			},
		],
	},
	computed: {
		test: function () {
			var data = [];
			return data;
		}
	},
	created(){
		var self = this
		axios
			.get('../index.php/main_page/get_all_posts')
			.then(function (response) {
				self.posts = response.data.posts;
			})
	},
	methods: {
		logout: function () {
			console.log ('logout');
		},
		logIn: function () {
			var self= this;
			if(self.login === ''){
				self.invalidLogin = true
			}
			else if(self.pass === ''){
				self.invalidLogin = false
				self.invalidPass = true
			}
			else{
				self.invalidLogin = false
				self.invalidPass = false
				axios.post('../index.php/main_page/login', {
					login: self.login,
					password: self.pass
				})
					.then(function (response) {
						setTimeout(function () {
							$('#loginModal').modal('hide');
						}, 500);
					})
			}
		},
		fiilIn: function (scrf) {
			var self= this;
			if(self.addSum === 0){
				self.invalidSum = true
			}
			
			else{
				console.log(scrf);
				self.invalidSum = false
				axios.post('../index.php/main_page/add_money', {
					sum: self.addSum,
					scrf: scrf,
				})
					.then(function (response) {
						setTimeout(function () {
							$('#addModal').modal('hide');
						}, 500);
					})
			}
		},
		addcomment: function(id, scrf) {
			var self = this;
			console.log(id);
			if(self.commentText === '') {
				self.invalidText = true
			}
			else {
				self.invalidText = false
				axios.post('../index.php/main_page/comment', {
					text: self.commentText,
					post_id: id,
					scrf: scrf,
				})
				.then(function (response) {
					setTimeout(function () {
						$('#postModal').modal('hide');
					}, 500);
				})
			}
		},
		openPost: function (id) {
			var self= this;
			axios
				.get('../index.php/main_page/get_post/' + id)
				.then(function (response) {
					self.post = response.data.post;
					if(self.post){
						setTimeout(function () {
							$('#postModal').modal('show');
						}, 500);
					}
				})
		},
		addLike: function (id) {
			var self= this;
			axios
				.get('../index.php/main_page/like?post_id='+ id)
				.then(function (response) {
					if( response.data.likes > 0) {
						self.likes = response.data.likes;
					}
				})

		},
		buyPack: function (id) {
			var self= this;
			axios.post('../index.php/main_page/buy_boosterpack', {
				id: id,
			})
				.then(function (response) {
					self.amount = response.data.amount
					if(self.amount !== 0){
						setTimeout(function () {
							$('#amountModal').modal('show');
						}, 500);
					}
				})
		}
	}
});

