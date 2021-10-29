const main = document.querySelector("#main");
const certDetail = document.createElement("div");

const display = (user) => {
  certDetail.innerHTML = `
<div class="container">
            <div class="container-cert">
                <h1>${user["họ tên"]}</h1>
                <img src ="./img/Tick.jfif"/>
               
                  <p class="container-cert__check">Tài liệu đã được xác nhận trên hệ thống</p>
                  <p>Được xác nhận lúc: ${user["time_add"]}</p>
                  <p>Loại bằng: ${user["type_cert"]}</p>
               
         
            </div>
            <div class="container-detail">
                <p class="container-detail__title">
                    Thông tin tín chỉ
                </p>
                <ul class="container-detail__list">
                    <li class="container-detail__item">
                        <span>Cấp cho</span>:${user["họ tên"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Ngành</span>: ${user["ngành học"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Loại bằng</span>: ${user["loại bằng"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Xét loại tốt nghiệp</span>: ${user["xếp loại tốt nghiệp"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Hình thức đào tạo</span>: ${user["hình thức đào tạo"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Nơi cấp</span>: ${user["tên trường"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Loại bằng</span>: ${user["type_cert"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Ngày cấp</span>: ${user["thời gian"]}
                    </li>

                    <li class="container-detail__item">
                        <span>Mã hiệu</span>: ${user["số hiệu"]}
                    </li>
                    <li class="container-detail__item">
                        <span>Số cấp vào bằng</span>: ${user["số vào sổ cấp bằng"]}
                    </li>


                </ul>
                <div class="circle"></div>

            </div>
        </div>
`;
  main.appendChild(certDetail);
};
//Ham tim` kiem

const getQueryParams = (url) => {
  let href = url;
  // this is an expression to get query strings
  let regexp = new RegExp("[?&]" + "=([^&#]*)", "i");
  let qString = regexp.exec(href);
  return qString ? qString[1] : null;
};

const params = getQueryParams(window.location.search);
console.log(params);
// set du lieu
const getUser = async () => {
  let url = `https://ipfs.io/ipfs/${params}`;
  let res = await fetch(url);

  return await res.json();
};
const error = document.querySelector(".error");
const renderUser = async () => {
  try {
    let user = await getUser();
    console.log(user["tên trường"]);
    display(user);
  } catch (err) {
    error.classList.add("active");
  }
};

renderUser();
