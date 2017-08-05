import React from 'react';

function TagLabel({ tag }) {
  return (
    <span className="label label-primary" style={{ marginLeft: 10 }}>{tag}</span>
  );
}

export default TagLabel;
