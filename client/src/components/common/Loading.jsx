import React from 'react';

function Loading() {
  return (
    <div style={ spinnerStyle }>
      <span className="fa fa-spinner fa-2x fa-spin"></span>
    </div>
  );
}

const spinnerStyle = {
  width: 50,
  height: 50,
  marginLeft: "auto",
  marginRight: "auto",
  marginTop: 10,
  fontSize: 16
}

export default Loading;
