const base_url ="https://ponnybeaute.revoapps.id/api/v1/";
const img_url ="https://ponnybeaute.revoapps.id/public/";

//Auth
const loginUrl = base_url+"auth/login";
const register = base_url+"auth/signup";
const userprofile = base_url+"auth/user";

//home
const banner = base_url+"banners";
const slider = base_url+"sliders";
const best_sale = base_url+"product/bestSeller";
const phobe = base_url+"product/phoebeChoices";
const rekomendasiProduk = base_url+"product/recommended";

//cart
const listCarturl = base_url+"cart/get";
const addtocart = base_url+"cart/save";
const removeCardUrl = base_url+"cart/destroy";
const applyCoupon = base_url+"checkout/applyCoupon";
const CostShipping = base_url+"shipping/couriers";
const cartSummary = base_url+"checkout/summary";
const cartChekouturl =base_url+"checkout/store";

//Account
const urlAddress =base_url+"shipping/address";
const urlOrder = base_url+"account/orders";



//master
const urlProv=base_url+"shipping/provinces";
const urlKab=base_url+"shipping/cities";
const urlKec=base_url+"shipping/subDistricts";
const saveAddressUrl = base_url+"shipping/saveAddress";
const removeAddressUrl = base_url+"shipping/delAddress";
