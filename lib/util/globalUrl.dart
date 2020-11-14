const base_url = "https://ponnybeaute.revoapps.id/api/v1/";
const img_url = "https://ponnybeaute.revoapps.id/public/";

//Auth
const loginUrl = base_url + "auth/login";
const register = base_url + "auth/signup";
const blogUrl = base_url + "blog";
const forumUrl = base_url + "forum";
const roomUrl = forumUrl + "/rooms";
const myRoomUrl = forumUrl + "/rooms";
const postRoom = base_url + "forum/joinRoom";
const blogDetailUrl = base_url + "blog/23";
const recomProduct = base_url + "product/recommended?chunk=3";
const skinkloUrl = base_url + "product/skinlopedia?keyword=&alphabet=";
const userprofile = base_url + "auth/user";
const loginOtp = base_url + "auth/login-otp";

//home
const banner = base_url + "banners";
const slider = base_url + "sliders";
const best_sale = base_url + "product/bestSeller";
const phobe = base_url + "product/phoebeChoices";
const rekomendasiProduk = base_url + "product/recommended";
const flashdealUrl = base_url+"product/flashDeal";

//cart
const listCarturl = base_url + "cart/get";
const addtocart = base_url + "cart/save";
const removeCardUrl = base_url + "cart/destroy";
const applyCoupon = base_url + "checkout/applyCoupon";
const CostShipping = base_url + "shipping/couriers";
const cartSummary = base_url + "checkout/summary";
const cartChekouturl = base_url + "checkout/store";
const preChekout = base_url + "checkout/preCheckout";
const addSample = base_url + "cart/sample";
const removeProductSample = base_url + "cart/delete/sample";
const rendemProduct = base_url + "cart/redeem";
const removePoinProduct = base_url + "cart/delete/point";

//payment
const paymentInfo = base_url + "payment/detail";
const paymentConfrim = base_url + "payment/confirmation";

//wishlist
const listOfwishlist = base_url + "product/wishlist";
const addToWishlist = base_url + "product/addToWishlist";
const removeToWishlist = base_url + "product/delFromWishlist";
const countOfwishlist = base_url + "product/wishlist/count";

//Account
const urlAddress = base_url + "shipping/address";
const urlOrder = base_url + "account/orders";
const urlUpdateProfile = base_url + "account/update";
const updateBeauteProfile = base_url + "account/update_beauty";

//Order
const urlTracking = base_url + "checkout/tracking";
const urlTerimaBarang = base_url + "checkout/receipt";

//Redeem
const rdmProduk = base_url + "product/redeemable";

//Review
const reviewList = base_url + "review/list";
const revieStore = base_url + "review/store";
const reviewNot = base_url + "review/not";
const myReview = base_url + "review/saya";

//Komplain
const listParamKompain = base_url+"checkout/complaint";

//Konsultasi
const voucherUrl = base_url+"consultation/voucher";
const voucherCheckout = base_url+"consultation/checkout";
const historyVoucher = base_url+"consultation/history";
const listVoucherActive = base_url+"consultation/myvoucher";
const inCallconsultation = base_url+"consultation/incall";
const updateDuration = base_url+"consultation/incallStatus";


//master
const urlProv = base_url + "shipping/provinces";
const urlKab = base_url + "shipping/cities";
const urlKec = base_url + "shipping/subDistricts";
const saveAddressUrl = base_url + "shipping/saveAddress";
const removeAddressUrl = base_url + "shipping/delAddress";
